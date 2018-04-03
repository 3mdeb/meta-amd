FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

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

COMPATIBLE_MACHINE_snowyowl = "snowyowl"
