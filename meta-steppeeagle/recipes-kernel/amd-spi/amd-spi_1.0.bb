DESCRIPTION = "This kernel module provides support for AMD SPI controller driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://spi_amd.c;endline=29;md5=8e7a9706367d146e5073510a6e176dc2"

inherit module

SRC_URI = "file://Makefile \
           file://spi_amd.c \
           file://spi_amd.h \
           file://spirom.c \
           file://spirom.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will take care of the rest
