FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.10"

KBRANCH_amdfalconx86 ?= "standard/common-pc-64/base"
SRCREV_machine_amdfalconx86 ?= "c100e8665052051487a17169748c457829d3f88c"
SRCREV_meta_amdfalconx86 ?= "fb6271a942b57bdc40c6e49f0203be153699f81c"

LINUX_VERSION_amdfalconx86 = "3.14.24"

COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"

KERNEL_FEATURES_append_amdfalconx86 += " cfg/smp.scc cfg/sound.scc"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-standard.scc \
				file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-gpu-config.cfg \
				file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
				${@bb.utils.contains("DISTRO", "mel", "", "file://disable-kgdb.cfg", d)} \
				file://usb-serial.cfg \
			       "
