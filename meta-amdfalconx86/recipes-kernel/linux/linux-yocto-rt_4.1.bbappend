FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:${THISDIR}/files:"

LINUX_VERSION_amdfalconx86 = "4.1.15"
KBRANCH_amdfalconx86 = "standard/preempt-rt/base"
SRCREV_machine_amdfalconx86 = "3188436876d5eaff8d48f82064367d4a65c3aa97"
SRCREV_meta_amdfalconx86 = "46bb64d605fd336d99fa05bab566b9553b40b4b4"

COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"
KERNEL_FEATURES_append_amdfalconx86 += " cfg/smp.scc cfg/sound.scc"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-preempt-rt.scc \
				file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-extra-config.cfg \
"
