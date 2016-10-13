FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

KBRANCH_amdx86 ?= "standard/preempt-rt/base"
KMACHINE_amdx86 ?= "common-pc-64"

SRCREV_machine_amdx86 ?= "76a02384d86df7b7499755f1650b5299740f5473"
SRCREV_meta_amdx86 ?= "e66032e2d93da24c6b9137dbbe66008c77f6d4aa"
LINUX_VERSION_amdx86 ?= "4.4.20"

SRC_URI_append_amdx86 += " \
	file://linux-yocto-amd-patches.scc \
	file://logo.cfg \
	file://console.cfg \
	file://drm.cfg \
	file://sound.cfg \
	file://hid.cfg \
	file://enable-imc.cfg \
	file://efi-partition.cfg \
	file://usb-serial.cfg \
	file://wifi-drivers.cfg \
	file://disable-intel-graphics.cfg \
	${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'file://enable-bluetooth.cfg', 'file://disable-bluetooth.cfg', d)} \
	${@bb.utils.contains('DISTRO', 'mel', 'file://enable-kgdb.cfg', 'file://disable-kgdb.cfg', d)} \
"

KERNEL_FEATURES_append_amdx86 = " cfg/smp.scc cfg/sound.scc"
