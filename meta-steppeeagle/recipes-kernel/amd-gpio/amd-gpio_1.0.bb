DESCRIPTION = "This kernel module provides support for AMD GPIO driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://gpio-amd.c;md5=8138870479f0a04d9f44538b888d5174 \
                    file://gpio-amd.h;md5=90e0a4a5923224a946619ee72f0f7522 \
                    file://Makefile;md5=1bede035509502b1669f098efbd904f3 \
                   "

inherit module

PR = "r0"
PV = "1.0"

SRC_URI = "file://Makefile \
           file://gpio-amd.c \
           file://gpio-amd.h \
          "

S = "${WORKDIR}"

# The inherit of module.bbclass will take care of the rest
