DESCRIPTION = "This kernel module provides support for AMD SPI controller driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://spi_amd.c;md5=80f01f3b969d0b1d633df6ba9edf4170 \
                    file://spi_amd.h;md5=488f986ada9e64f6b5ee6d55c269ae1b \
                    file://spirom.c;md5=122bee09c280ae24c3b97bec1359a94c \
                    file://spirom.h;md5=8de0c535224dbd8ecd2f40ef29c15d0a \
		    file://Makefile;md5=8ea80a6d4ae15bcf922d090df6cfdd4c \
		   "

inherit module

PR = "r0"
PV = "1.0"

SRC_URI = "file://Makefile \
           file://spi_amd.c \
           file://spi_amd.h \
           file://spirom.c \
           file://spirom.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will take care of the rest
