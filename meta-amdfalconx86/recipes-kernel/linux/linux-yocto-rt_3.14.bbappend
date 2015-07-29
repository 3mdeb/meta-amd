FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.10"

KBRANCH_amdfalconx86 ?= "standard/preempt-rt/base"
SRCREV_machine_amdfalconx86 ?= "baad552ea168dc31db31f0be188edefaa28a4aec"
SRCREV_meta_amdfalconx86 ?= "0dafe73796dffc0747d2b24eb7c5569a803b8892"

LINUX_VERSION_amdfalconx86 = "3.14.24"

COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"

KERNEL_FEATURES_append_amdfalconx86 += " cfg/smp.scc cfg/sound.scc"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-preempt-rt.scc \
				file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
				${@bb.utils.contains("DISTRO", "mel", "", "file://disable-kgdb.cfg", d)} \
				file://usb-serial.cfg \
			       "
