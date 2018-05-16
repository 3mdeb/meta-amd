FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto-${LINUX_VERSION}:"

PR := "${INC_PR}.1"

KMACHINE_amdx86 ?= "common-pc-64"
SRCREV_meta_amdx86 ?= "803b8d600e45afa0375459bf599fe365571a3866"
LINUX_VERSION_amdx86 ?= "4.9.21"

SRC_URI_append_amdx86 += " \
	file://hid.cfg \
	file://efi-partition.cfg \
	file://usb-serial.cfg \
	file://wifi-drivers.cfg \
	${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'file://enable-bluetooth.cfg', 'file://disable-bluetooth.cfg', d)} \
	${@bb.utils.contains('DISTRO', 'mel', 'file://enable-kgdb.cfg', 'file://disable-kgdb.cfg', d)} \
"

KERNEL_FEATURES_append_amdx86 = " cfg/smp.scc"
