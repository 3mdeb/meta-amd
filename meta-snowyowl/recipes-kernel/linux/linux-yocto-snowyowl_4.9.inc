FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

KMACHINE_snowyowl ?= "common-pc-64"
SRCREV_meta_snowyowl ?= "803b8d600e45afa0375459bf599fe365571a3866"
LINUX_VERSION_snowyowl ?= "4.9.21"

SRC_URI_append_snowyowl += "file://snowyowl-user-features.scc \
    file://snowyowl-user-patches.scc \
    file://snowyowl.cfg \
    file://snowyowl-user-config.cfg \
    file://snowyowl-extra-config.cfg \
    file://logo.cfg \
    file://sound.cfg \
    file://hid.cfg \
    file://efi-partition.cfg \
    file://usb-serial.cfg \
    file://wifi-drivers.cfg \
    file://amd-xgbe.cfg \
    file://amd-ccp.cfg \
    file://kvm.cfg \
    file://afalg.cfg \
    ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'file://enable-bluetooth.cfg', 'file://disable-bluetooth.cfg', d)} \
    ${@bb.utils.contains('DISTRO', 'mel', 'file://enable-kgdb.cfg', 'file://disable-kgdb.cfg', d)} \
"

KERNEL_FEATURES_append_snowyowl = " cfg/smp.scc cfg/sound.scc"

COMPATIBLE_MACHINE_snowyowl = "snowyowl"
