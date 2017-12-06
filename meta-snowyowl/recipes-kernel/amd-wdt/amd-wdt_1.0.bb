DESCRIPTION = "This kernel module provides support for AMD Watchdog driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://amd_wdt.c;endline=29;md5=8e7a9706367d146e5073510a6e176dc2"

inherit module kernel-openssl

SRC_URI = "file://Makefile \
           file://amd_wdt.c \
           file://amd_wdt.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will take care of the rest
