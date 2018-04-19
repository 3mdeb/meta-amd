FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${LINUX_VERSION}:"

PR := "${INC_PR}.1"

KMACHINE_amdx86 ?= "common-pc-64"
KBRANCH_amdx86 ?= "standard/base"

SRCREV_machine_amdx86 ?= "81055b89bd32414ecaf95156ce9a5fa6643e530a"
SRCREV_meta_amdx86 ?= "803b8d600e45afa0375459bf599fe365571a3866"
LINUX_VERSION_amdx86 ?= "4.9.21"

SRC_URI_append_amdx86 = " file://upstream-backports.scc"

KERNEL_FEATURES_append_amdx86 = " cfg/smp.scc"
