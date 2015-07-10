DESCRIPTION = "This kernel module provides support for AMD GPIO driver"
LICENSE = "BSD | GPLv2"
LIC_FILES_CHKSUM = "file://gpio-amd.c;md5=2a772a9977520ddf9780e9760062b621 \
		    file://gpio-amd.h;md5=7b49b68331706afd157c54bafe6426cb \
		    file://Makefile;md5=1cf995f5213fae50197541e5992b0d4e \
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
