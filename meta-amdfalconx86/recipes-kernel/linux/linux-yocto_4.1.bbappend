FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:${THISDIR}/files:"

LINUX_VERSION_amdfalconx86 = "4.1.15"
KBRANCH_amdfalconx86 = "standard/base"
SRCREV_machine_amdfalconx86 = "788dfc9859321c09f1c58696bf8998f90ccb4f51"
SRCREV_meta_amdfalconx86 = "46bb64d605fd336d99fa05bab566b9553b40b4b4"
KMACHINE_amdfalconx86 = "common-pc-64"

COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"
KERNEL_FEATURES_append_amdfalconx86 += " cfg/smp.scc cfg/sound.scc"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-standard.scc \
				file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-gpu-config.cfg \
				file://amdfalconx86-extra-config.cfg \
"
