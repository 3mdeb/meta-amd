FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

KMACHINE_v1000 ?= "common-pc-64"
SRCREV_meta_v1000 ?= "803b8d600e45afa0375459bf599fe365571a3866"
LINUX_VERSION_v1000 ?= "4.9.21"

SRC_URI_append_v1000 += "file://v1000-user-features.scc \
    file://v1000-user-patches.scc \
    file://v1000.cfg \
    file://v1000-user-config.cfg \
    file://v1000-gpu-config.cfg \
    file://v1000-extra-config.cfg \
    file://hid.cfg \
"

KERNEL_FEATURES_append_v1000 = " cfg/smp.scc cfg/sound.scc"

COMPATIBLE_MACHINE_v1000 = "v1000"
