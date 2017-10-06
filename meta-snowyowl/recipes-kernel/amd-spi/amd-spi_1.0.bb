DESCRIPTION = "This kernel module provides support for AMD SPI controller driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://spi_amd.c;md5=35fbdadc52e6d2b1d052ee4c19e8fc6d \
                    file://spi_amd.h;md5=488f986ada9e64f6b5ee6d55c269ae1b \
                    file://spirom.c;md5=ec2142faf7c64a85563fcaa129772fc0 \
                    file://spirom.h;md5=8de0c535224dbd8ecd2f40ef29c15d0a \
		    file://Makefile;md5=8ea80a6d4ae15bcf922d090df6cfdd4c \
		   "

inherit module


SRC_URI = "file://Makefile \
           file://spi_amd.c \
           file://spi_amd.h \
           file://spirom.c \
           file://spirom.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will take care of the rest
