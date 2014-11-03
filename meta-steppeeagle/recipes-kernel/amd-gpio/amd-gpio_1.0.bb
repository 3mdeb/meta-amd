DESCRIPTION = "This kernel module provides support for AMD GPIO driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://gpio-amd.c;md5=a48cb57d6711b1801a62ea03a87e2e76 \
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

# Kernel module packages MUST begin with 'kernel-module-', otherwise
# multilib image generation can fail.
#
# The following line is only necessary if the recipe name does not begin
# with kernel-module-.
#
PKG_${PN} = "kernel-module-${PN}"

FILES_${PN} += "${sysconfdir}"
