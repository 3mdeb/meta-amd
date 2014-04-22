#ifndef _AMD_WDT_H_
#define _AMD_WDT_H_

/* Module and version information */
#define WDT_VERSION "0.1"
#define WDT_MODULE_NAME "AMD watchdog timer"
#define WDT_DRIVER_NAME   WDT_MODULE_NAME ", v" WDT_VERSION

#define WATCHDOG_HEARTBEAT	60	/* 60 units default heartbeat. */
#define MAX_LENGTH		(8 + 1)	/* shutdown has 8 characters + NULL character */

/* Watchdog register definitions */
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

#define AMD_PM_WATCHDOG_TIMER_EN	0x48
 #define AMD_PM_WATCHDOG_DECODE_EN	(1 << 0)
 #define AMD_PM_WATCHDOG_DISABLE	(1 << 1)

#define AMD_PM_WATCHDOG_TIMER_CONFIG	0x4C
 #define AMD_PM_WATCHDOG_32KHZ_RES	0x0
 #define AMD_PM_WATCHDOG_1HZ_RES	0x3
#define AMD_PM_WATCHDOG_CONFIG_MASK	0x3

/* IO port address for indirect access using ACPI PM registers */
#define AMD_IO_PM_INDEX_REG		0xCD6
#define AMD_IO_PM_DATA_REG		0xCD7

#define AMD_PM_WATCHDOG_BASE0		0x24
#define AMD_PM_WATCHDOG_BASE1		0x25
#define AMD_PM_WATCHDOG_BASE2		0x26
#define AMD_PM_WATCHDOG_BASE3		0x27

#define AMD_ACPI_MMIO_ADDR_MASK		~0x1FFF

/* Watchdog device status */
#define AMD_WDOG_ACTIVE			0	/* Is the watchdog running/active */
#define AMD_WDOG_DEV_OPEN		1	/* Opended via /dev/watchdog */
#define AMD_WDOG_ALLOW_RELEASE		2	/* Did we receive the magic char? */
#define AMD_WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set? */

#endif /* _AMD_WDT_H_ */
