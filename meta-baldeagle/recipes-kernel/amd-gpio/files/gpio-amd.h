#ifndef _AMD_GPIO_H_
#define _AMD_GPIO_H_

/* Module and version information */
#define GPIO_VERSION "0.1"
#define GPIO_MODULE_NAME "AMD GPIO"
#define GPIO_DRIVER_NAME   GPIO_MODULE_NAME ", v" GPIO_VERSION

#define DRV_NAME "amd-gpio"

/* GPIO register definitions */
#define AMD_GPIO_MEM_MAP_OFFSET		0x100
#define AMD_GPIO_MEM_MAP_SIZE		0x100

#define AMD_IOMUX_MEM_MAP_OFFSET	0xD00
#define AMD_IOMUX_MEM_MAP_SIZE		0x100

#define AMD_PM_IOPORTS_SIZE		0x02

/* IO port address for indirect access using the ACPI PM registers */
#define AMD_IO_PM_INDEX_REG		0xCD6
#define AMD_IO_PM_DATA_REG		0xCD7

#define AMD_GPIO_NUM_PINS		230	/* GPIO0 - GPIO229 */

#define AMD_GPIO_OWNER_EC		(1 << 0)
#define AMD_GPIO_OWNER_HOST		(1 << 1)
#define AMD_GPIO_SET_STICKY		(1 << 2)
#define AMD_GPIO_DISABLE_PULLUP		(1 << 3)
#define AMD_GPIO_ENABLE_PULLDOWN	(1 << 4)
#define AMD_GPIO_DISABLE_OUTPUT		(1 << 5)
#define AMD_GPIO_SET_OUTPUT		(1 << 6)
#define AMD_GPIO_GET_INPUT		(1 << 7)

#define AMD_IOMUX_ENABLE_FUNC0		0x0
#define AMD_IOMUX_ENABLE_FUNC1		0x1
#define AMD_IOMUX_ENABLE_FUNC2		0x2
#define AMD_IOMUX_ENABLE_FUNC3		0x3
 #define AMD_IOMUX_GPIO_MASK		0x03

#define AMD_PM_GPIO_BASE0		0x24
#define AMD_PM_GPIO_BASE1		0x25
#define AMD_PM_GPIO_BASE2		0x26
#define AMD_PM_GPIO_BASE3		0x27

#define AMD_ACPI_MMIO_ADDR_MASK		~0x1FFF

/* GPIO pin mode definitions */
#define AMD_GPIO_MODE_RESV		0	/* Reserved */
#define AMD_GPIO_MODE_ANY		1	/* Either input or output */
#define AMD_GPIO_MODE_INPUT		2	/* GPI */
#define AMD_GPIO_MODE_OUTPUT		3	/* GPO */

#endif /* _AMD_GPIO_H_ */
