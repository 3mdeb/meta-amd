DESCRIPTION = "This kernel module provides support for AMD SPI controller driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://spi_amd.c;md5=bca93a3bd8cbdabafd4089daf5109768 \
                    file://spi_amd.h;md5=67ba12b2bcfda1402435aebf18cda6bd \
                    file://spirom.c;md5=558c5e03489d2d7792c03dcf7e2539ab \
                    file://spirom.h;md5=332ef940b1cb318fc8ecd9b1ba5940be \
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


# Kernel module packages MUST begin with 'kernel-module-', otherwise
# multilib image generation can fail.
#
# The following line is only necessary if the recipe name does not begin
# with kernel-module-.
#
PKG_${PN} = "kernel-module-${PN}"

FILES_${PN} += "${sysconfdir}"
