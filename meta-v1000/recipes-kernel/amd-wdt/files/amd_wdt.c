/*****************************************************************************
*
* Copyright (c) 2014, Advanced Micro Devices, Inc.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Advanced Micro Devices, Inc. nor the names of
*       its contributors may be used to endorse or promote products derived
*       from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL ADVANCED MICRO DEVICES, INC. BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
***************************************************************************/
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/types.h>
#include <linux/watchdog.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/ioport.h>
#include <linux/platform_device.h>
#include <linux/io.h>

#include "amd_wdt.h"

/* internal variables */
static u32 wdtbase_phys;
static void __iomem *wdtbase;
static DEFINE_SPINLOCK(wdt_lock);
static struct pci_dev *amd_wdt_pci;

/* watchdog platform device */
static struct platform_device *amd_wdt_platform_device;

/* module parameters */
static int heartbeat = AMD_WDT_DEFAULT_TIMEOUT;
module_param(heartbeat, int, 0);
MODULE_PARM_DESC(heartbeat, "Watchdog timeout in frequency units. "
		 "(default="  __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");

static char frequency[MAX_LENGTH] = "1s";
module_param_string(frequency, frequency, MAX_LENGTH, 0);
MODULE_PARM_DESC(frequency, "Watchdog timer frequency units (32us, "
		 "10ms, 100ms, 1s). (default=1s)");

static bool nowayout = WATCHDOG_NOWAYOUT;
module_param(nowayout, bool, 0);
MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started"
		" (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

static char action[MAX_LENGTH] = "reboot";
module_param_string(action, action, MAX_LENGTH, 0);
MODULE_PARM_DESC(action, "Watchdog action (reboot/shutdown). (default=reboot) ");

/*
 * Watchdog specific functions
 */
static int amd_wdt_set_timeout(struct watchdog_device *wdt_dev, unsigned int t)
{
	unsigned long flags;

	/*
	 * In ideal cases the limits will be checked by Watchdog core itself,
	 * but there might be cases when we call this function directly from
	 * somewhere else. So check the limits here.
	 */
	if (t < AMD_WDT_MIN_TIMEOUT)
		heartbeat = t = AMD_WDT_MIN_TIMEOUT;
	else if (t > AMD_WDT_MAX_TIMEOUT)
		heartbeat = t = AMD_WDT_MAX_TIMEOUT;

	/* Write new timeout value to watchdog */
	spin_lock_irqsave(&wdt_lock, flags);
	writel(t, AMD_WDT_COUNT(wdtbase));
	spin_unlock_irqrestore(&wdt_lock, flags);

	wdt_dev->timeout = t;

	return 0;
}

static int amd_wdt_ping(struct watchdog_device *wdt_dev)
{
	u32 val;
	unsigned long flags;

	/* Trigger watchdog */
	spin_lock_irqsave(&wdt_lock, flags);

	val = readl(AMD_WDT_CONTROL(wdtbase));
	val |= AMD_WDT_TRIGGER_BIT;
	writel(val, AMD_WDT_CONTROL(wdtbase));

	spin_unlock_irqrestore(&wdt_lock, flags);

	return 0;
}

static int amd_wdt_start(struct watchdog_device *wdt_dev)
{
	u32 val;
	unsigned long flags;

	/* Enable the watchdog timer */
	spin_lock_irqsave(&wdt_lock, flags);

	val = readl(AMD_WDT_CONTROL(wdtbase));
	val |= AMD_WDT_START_STOP_BIT;
	writel(val, AMD_WDT_CONTROL(wdtbase));

	spin_unlock_irqrestore(&wdt_lock, flags);

	/* Trigger the watchdog timer */
	amd_wdt_ping(wdt_dev);

	return 0;
}

static int amd_wdt_stop(struct watchdog_device *wdt_dev)
{
	u32 val;
	unsigned long flags;

	/* Disable the watchdog timer */
	spin_lock_irqsave(&wdt_lock, flags);

	val = readl(AMD_WDT_CONTROL(wdtbase));
	val &= ~AMD_WDT_START_STOP_BIT; 
	writel(val, AMD_WDT_CONTROL(wdtbase));

	spin_unlock_irqrestore(&wdt_lock, flags);

	return 0;
}

static unsigned int amd_wdt_get_timeleft(struct watchdog_device *wdt_dev)
{
	u32 val;
	unsigned long flags;

	spin_lock_irqsave(&wdt_lock, flags);
	val = readl(AMD_WDT_COUNT(wdtbase));
	spin_unlock_irqrestore(&wdt_lock, flags);

	/* Mask out the upper 16-bits and return */
	return val & AMD_WDT_COUNT_MASK;
}

static unsigned int amd_wdt_status(struct watchdog_device *wdt_dev)
{
	return wdt_dev->status;
}

static struct watchdog_ops amd_wdt_ops = {
	.owner		= THIS_MODULE,
	.start		= amd_wdt_start,
	.stop		= amd_wdt_stop,
	.ping		= amd_wdt_ping,
	.status		= amd_wdt_status,
	.set_timeout	= amd_wdt_set_timeout,
	.get_timeleft	= amd_wdt_get_timeleft,
};
static struct watchdog_info amd_wdt_info = {
	.options		= WDIOF_SETTIMEOUT |
				  WDIOF_MAGICCLOSE |
				  WDIOF_KEEPALIVEPING,
	.firmware_version	= 0,
	.identity		= WDT_MODULE_NAME,
};

static struct watchdog_device amd_wdt_dev = {
	.info		= &amd_wdt_info,
	.ops		= &amd_wdt_ops,
};

/*
 * The PCI Device ID table below is used to identify the platform
 * the driver is supposed to work for. Since this is a platform
 * device, we need a way for us to be able to find the correct
 * platform when the driver gets loaded, otherwise we should
 * bail out.
 */
static const struct pci_device_id amd_wdt_pci_tbl[] = {
	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CARRIZO_SMBUS, PCI_ANY_ID,
	  PCI_ANY_ID, },
	{ 0, },
};
MODULE_DEVICE_TABLE(pci, amd_wdt_pci_tbl);

static unsigned char amd_wdt_setupdevice(void)
{
	struct pci_dev *dev = NULL;
	u32 val;

	/* Match the PCI device */
	for_each_pci_dev(dev) {
		if (pci_match_id(amd_wdt_pci_tbl, dev) != NULL) {
			amd_wdt_pci = dev;
			break;
		}
	}

	if (!amd_wdt_pci)
		return 0;

	/* Watchdog Base Address starts from ACPI MMIO Base Address + 0xB00 */
	wdtbase_phys = AMD_ACPI_MMIO_BASE + AMD_WDT_MEM_MAP_OFFSET;
	if (!request_mem_region_exclusive(wdtbase_phys, AMD_WDT_MEM_MAP_SIZE,
					  "AMD Watchdog")) {
		pr_err("mmio address 0x%04x already in use\n", wdtbase_phys);
		goto exit;
	}

	wdtbase = ioremap(wdtbase_phys, AMD_WDT_MEM_MAP_SIZE);
	if (!wdtbase) {
		pr_err("failed to get wdtbase address\n");
		goto unreg_mem_region;
	}

	/* Enable watchdog timer and decode bit */
	outb(AMD_PM_WATCHDOG_EN_REG, AMD_IO_PM_INDEX_REG);
	val = inb(AMD_IO_PM_DATA_REG);
	val |= AMD_PM_WATCHDOG_TIMER_EN;
	outb(val, AMD_IO_PM_DATA_REG);

	/* Set the watchdog timer resolution */
	outb(AMD_PM_WATCHDOG_CONFIG_REG, AMD_IO_PM_INDEX_REG);
	val = inb(AMD_IO_PM_DATA_REG);
	/* Clear the previous frequency setting, if any */
	val &= ~AMD_PM_WATCHDOG_CONFIG_MASK;

	/*
	 * Now set the frequency depending on the module load parameter.
	 * In case the user passes an invalid argument, we consider the
	 * frequency to be of 1 second resolution.
	 */
	if (strncmp(frequency, "32us", 4) == 0)
		val |= AMD_PM_WATCHDOG_32USEC_RES;
	else if (strncmp(frequency, "10ms", 4) == 0)
		val |= AMD_PM_WATCHDOG_10MSEC_RES;
	else if (strncmp(frequency, "100ms", 5) == 0)
		val |= AMD_PM_WATCHDOG_100MSEC_RES;
	else {
		val |= AMD_PM_WATCHDOG_1SEC_RES;
		if (strncmp(frequency, "1s", 2) != 0)
			strncpy(frequency, "1s", 2);
	}

	outb(val, AMD_IO_PM_DATA_REG);

	/* Check to see if last reboot was due to watchdog timeout */
	val = readl(AMD_WDT_CONTROL(wdtbase));


	/* Clear out the old status */

	/*
	 * Set the watchdog action depending on module load parameter.
	 *
	 * If action is specified anything other than reboot or shutdown,
	 * we default it to reboot.
	 */
	if (strncmp(action, "shutdown", 8) == 0)
		val |= AMD_WDT_ACTION_RESET_BIT;
	else {
		val &= ~AMD_WDT_ACTION_RESET_BIT;
		/* The statement below is required for when the action
		 * is set anything other than reboot.
		 */
		if (strncmp(action, "reboot", 6) != 0)
			strncpy(action, "reboot", 6);
	}

	writel(val, AMD_WDT_CONTROL(wdtbase));

	return 1;

unreg_mem_region:
	release_mem_region(wdtbase_phys, AMD_WDT_MEM_MAP_SIZE);
exit:
	return 0;
}

static int amd_wdt_init(struct platform_device *dev)
{
	int ret;
	u32 val;

	/* Identify our device and initialize watchdog hardware */
	if (!amd_wdt_setupdevice())
		return -ENODEV;
	val = readl(AMD_WDT_CONTROL(wdtbase));
	if (val & AMD_WDT_FIRED_BIT)
		amd_wdt_dev.bootstatus |= WDIOF_CARDRESET;
	else
		amd_wdt_dev.bootstatus &= ~WDIOF_CARDRESET;

	pr_info("Watchdog reboot %sdetected\n",
		(val & AMD_WDT_FIRED_BIT) ? "" : "not ");

	/* Clear out the old status */
	val |= AMD_WDT_FIRED_BIT;
	writel(val, AMD_WDT_CONTROL(wdtbase));

	amd_wdt_dev.timeout = heartbeat;
	amd_wdt_dev.min_timeout = AMD_WDT_MIN_TIMEOUT;
	amd_wdt_dev.max_timeout = AMD_WDT_MAX_TIMEOUT;
	watchdog_set_nowayout(&amd_wdt_dev, nowayout);

	/* Make sure watchdog is not running */
	amd_wdt_stop(&amd_wdt_dev);

	/* Set Watchdog timeout */
	amd_wdt_set_timeout(&amd_wdt_dev, heartbeat);

	ret = watchdog_register_device(&amd_wdt_dev);
	if (ret != 0) {
		pr_err("Watchdog timer: cannot register watchdog device"
		       " (err=%d)\n", ret);
		goto exit;
	}

		pr_info("initialized (0x%p). (timeout=%d units) (frequency=%s) "
		"(nowayout=%d) (action=%s)\n", wdtbase, heartbeat, frequency,
		nowayout, action);

	return 0;

exit:
	iounmap(wdtbase);
	release_mem_region(wdtbase_phys, AMD_WDT_MEM_MAP_SIZE);
	return ret;
}

static void amd_wdt_cleanup(void)
{
	/* Stop the timer before we leave */
	if (!nowayout)
		amd_wdt_stop(NULL);

	watchdog_unregister_device(&amd_wdt_dev);
	iounmap(wdtbase);
	release_mem_region(wdtbase_phys, AMD_WDT_MEM_MAP_SIZE);
}

static int amd_wdt_remove(struct platform_device *dev)
{
	if (wdtbase)
		amd_wdt_cleanup();

	return 0;
}

static void amd_wdt_shutdown(struct platform_device *dev)
{
	amd_wdt_stop(NULL);
}

static struct platform_driver amd_wdt_driver = {
	.probe		= amd_wdt_init,
	.remove		= amd_wdt_remove,
	.shutdown	= amd_wdt_shutdown,
	.driver		= {
		.owner	= THIS_MODULE,
		.name	= WDT_MODULE_NAME,
	},
};

static int __init amd_wdt_init_module(void)
{
	int err;

	pr_info("AMD WatchDog Timer Driver v%s\n", WDT_VERSION);

	err = platform_driver_register(&amd_wdt_driver);
	if (err)
		return err;

	amd_wdt_platform_device = platform_device_register_simple(
					WDT_MODULE_NAME, -1, NULL, 0);
	if (IS_ERR(amd_wdt_platform_device)) {
		err = PTR_ERR(amd_wdt_platform_device);
		goto unreg_platform_driver;
	}

	return 0;

unreg_platform_driver:
	platform_driver_unregister(&amd_wdt_driver);
	return err;
}

static void __exit amd_wdt_cleanup_module(void)
{
	platform_device_unregister(amd_wdt_platform_device);
	platform_driver_unregister(&amd_wdt_driver);
	pr_info("AMD Watchdog Module Unloaded\n");
}

module_init(amd_wdt_init_module);
module_exit(amd_wdt_cleanup_module);

MODULE_AUTHOR("Arindam Nath <arindam.nath@amd.com>");
MODULE_DESCRIPTION("Watchdog timer driver for AMD chipsets");
MODULE_LICENSE("Dual BSD/GPL");
