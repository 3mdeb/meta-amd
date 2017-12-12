#ifndef _AMD_WDT_H_
#define _AMD_WDT_H_

/* Module and version information */
#define WDT_VERSION "1.0"
#define WDT_MODULE_NAME "AMD watchdog timer"
#define WDT_DRIVER_NAME   WDT_MODULE_NAME ", v" WDT_VERSION

#define AMD_WDT_DEFAULT_TIMEOUT		60	/* 60 units default heartbeat. */
#define AMD_WDT_MIN_TIMEOUT	0x0001	/* minimum timeout value */
#define AMD_WDT_MAX_TIMEOUT	0xFFFF	/* maximum timeout value */
#define MAX_LENGTH		(8 + 1)	/* shutdown has 8 characters + NULL character */

/* Watchdog register definitions */
#define AMD_ACPI_MMIO_BASE		0xFED80000
#define AMD_WDT_MEM_MAP_OFFSET		0xB00
#define AMD_WDT_MEM_MAP_SIZE		0x100

#define AMD_WDT_CONTROL(base)		((base) + 0x00) /* Watchdog Control */
 #define AMD_WDT_START_STOP_BIT		(1 << 0)
 #define AMD_WDT_FIRED_BIT		(1 << 1)
 #define AMD_WDT_ACTION_RESET_BIT	(1 << 2)
 #define AMD_WDT_DISABLE_BIT		(1 << 3)
 /* 6:4 bits Reserved */
 #define AMD_WDT_TRIGGER_BIT		(1 << 7)
#define AMD_WDT_COUNT(base)		((base) + 0x04) /* Watchdog Count */
 #define AMD_WDT_COUNT_MASK		0xFFFF

#define AMD_PM_WATCHDOG_EN_REG		0x00
 #define AMD_PM_WATCHDOG_TIMER_EN	(0x01 << 7)

#define AMD_PM_WATCHDOG_CONFIG_REG	0x03
 #define AMD_PM_WATCHDOG_32USEC_RES	0x0
 #define AMD_PM_WATCHDOG_10MSEC_RES	0x1
 #define AMD_PM_WATCHDOG_100MSEC_RES	0x2
 #define AMD_PM_WATCHDOG_1SEC_RES	0x3
#define AMD_PM_WATCHDOG_CONFIG_MASK	0x3

/* IO port address for indirect access using ACPI PM registers */
#define AMD_IO_PM_INDEX_REG		0xCD6
#define AMD_IO_PM_DATA_REG		0xCD7

#define AMD_ACPI_MMIO_ADDR_MASK		~0x1FFF
#define PCI_DEVICE_ID_AMD_CARRIZO_SMBUS 0x790B

#endif /* _AMD_WDT_H_ */
