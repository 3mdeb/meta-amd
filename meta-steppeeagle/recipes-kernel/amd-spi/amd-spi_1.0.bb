DESCRIPTION = "This kernel module provides support for AMD SPI controller driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://spi_amd.c;md5=3cbc6410f1e2b6009f1a74731f6fc557 \
                    file://spi_amd.h;md5=2233c2a926f120b07153e3ea0ba7474f \
                    file://spirom.c;md5=1f5bba5ab39fb0759286aab09b55bc84 \
                    file://spirom.h;md5=56f117ed31b82b02182c7a491364d112 \
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
