DESCRIPTION = "This kernel module provides support for AMD GPIO driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://gpio-amd.c;endline=29;md5=cff1a39058f2ba37f8a18768e23e86ab"

inherit module

SRC_URI = "file://Makefile \
           file://gpio-amd.c \
           file://gpio-amd.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will take care of the rest
