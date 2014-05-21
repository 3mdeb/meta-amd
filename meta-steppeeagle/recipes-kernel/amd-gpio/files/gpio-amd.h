#ifndef _AMD_GPIO_H_
#define _AMD_GPIO_H_

#include <linux/types.h>

/* Module and version information */
#define GPIO_VERSION "0.1"
#define GPIO_MODULE_NAME "AMD GPIO"
#define GPIO_DRIVER_NAME   GPIO_MODULE_NAME ", v" GPIO_VERSION

#define DRV_NAME "amd-gpio"

/* GPIO register definitions */
#define AMD_GPIO_ACPIMMIO_BASE		0xFED80000
#define AMD_GPIO_BANK_OFFSET		0x1500
#define AMD_GPIO_MEM_MAP_SIZE		0x300
#define AMD_GPIO_MSWITCH		63

#define AMD_IOMUX_MEM_MAP_OFFSET	0x0D00
#define AMD_IOMUX_MEM_MAP_SIZE		0x100

#define AMD_PM_IOPORTS_SIZE		0x02

/* IO port address for indirect access using the ACPI PM registers */
#define AMD_IO_PM_INDEX_REG		0xCD6
#define AMD_IO_PM_DATA_REG		0xCD7

#define AMD_GPIO_NUM_PINS		184

#define AMD_GPIO_DEB_TIMEOUT0		(0)	/* debouncing logic disabled */
#define AMD_GPIO_DEB_TIMEOUT1		(1)
#define AMD_GPIO_DEB_TIMEOUT_MASK	(7)
#define AMD_GPIO_DEB_TIMEOUTUNIT	(1 << 4)
#define AMD_GPIO_DEB_CTRL		(3 << 5)
#define AMD_GPIO_LEVL_TRG		(1 << 8)	/* 0 - edge , 1 level */
#define AMD_GPIO_ACTIVE_LEVEL		(3 << 9)
#define AMD_GPIO_INTERPT_ENABLE		(3 << 11)
#define AMD_GPIO_WAKECTRL		(7 << 13)
#define AMD_GPIO_GET_INPUT		(1 << 16)
#define AMD_GPIO_DRV_STRENGTH(x)	(((x) & 3) << 17)
#define AMD_GPIO_PULLUP_SEL		(1 << 19)
#define AMD_GPIO_PULLUP_ENABLE		(1 << 20)
#define AMD_GPIO_PULLDN_ENABLE		(1 << 21)
#define AMD_GPIO_SET_OUTPUT		(1 << 22)
#define AMD_GPIO_OUTPUT_ENABLE		(1 << 23)
#define AMD_GPIO_SWCTRL_IN		(1 << 24)
#define AMD_GPIO_SWCTRL_EN		(1 << 25)
#define AMD_GPIO_INTERPT_STATUS		(1 << 28)
#define AMD_GPIO_WAKE_STATUS		(1 << 29)

#define AMD_GPIO_WAKE_EN		(1 << 31)
#define AMD_GPIO_INTERRUPT_EN		(1 << 30)

#define AMD_IOMUX_ENABLE_FUNC0		0x0
#define AMD_IOMUX_ENABLE_FUNC1		0x1
#define AMD_IOMUX_ENABLE_FUNC2		0x2
#define AMD_IOMUX_ENABLE_FUNC3		0x3
#define AMD_IOMUX_GPIO_MASK		0x03

#define AMD_PM_GPIO_BASE0		0x24
#define AMD_PM_GPIO_BASE1		0x25
#define AMD_PM_GPIO_BASE2		0x26
#define AMD_PM_GPIO_BASE3		0x27




/* GPIO pin mode definitions */
#define AMD_GPIO_MODE_RESV		0	/* Reserved */
#define AMD_GPIO_MODE_ANY		1	/* Either input or output */
#define AMD_GPIO_MODE_INPUT		2	/* GPI */
#define AMD_GPIO_MODE_OUTPUT		3	/* GPO */

/* IOCTL numbers */

typedef struct {
	int offset;
	int value;
}debug_data;

#define GPIO_TEST_IOC_MAGIC			'k'
#define GPIO_IOC_SWCTRLIN  _IOW(GPIO_TEST_IOC_MAGIC, 1, debug_data)
#define GPIO_IOC_SWCTRLEN  _IOW(GPIO_TEST_IOC_MAGIC, 2, debug_data)

#endif /* _AMD_GPIO_H_ */
