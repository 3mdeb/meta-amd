DESCRIPTION = "This kernel module provides support for RealTek R8168 driver"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit module

PR = "r0"
PV = "8.040.00"

SRC_URI = "file://0002-${PN}-${PV}.tar.bz2 \
	   file://0001-r8168-adjust-Makefiles-for-Yocto-environment.patch \
"

