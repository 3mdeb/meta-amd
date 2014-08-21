DESCRIPTION = "This kernel module provides support for AMD SPI controller driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://spi_amd.c;md5=053ef6a02a8242fbb536a45df556c7a7 \
                    file://spi_amd.h;md5=b73106fb4d18369d420b9de1d1406b3a \
                    file://spirom.c;md5=1f5bba5ab39fb0759286aab09b55bc84 \
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


# Kernel module packages MUST begin with 'kernel-module-', otherwise
# multilib image generation can fail.
#
# The following line is only necessary if the recipe name does not begin
# with kernel-module-.
#
PKG_${PN} = "kernel-module-${PN}"

FILES_${PN} += "${sysconfdir}"
