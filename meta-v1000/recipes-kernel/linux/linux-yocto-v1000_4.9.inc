FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_v1000 += "file://v1000-user-features.scc \
    file://v1000-user-patches.scc \
    file://v1000.cfg \
    file://v1000-user-config.cfg \
    file://v1000-gpu-config.cfg \
    file://v1000-extra-config.cfg \
    file://hid.cfg \
    file://wifi-drivers.cfg \
    ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'file://enable-bluetooth.cfg', 'file://disable-bluetooth.cfg', d)} \
    ${@bb.utils.contains('DISTRO', 'mel', 'file://enable-kgdb.cfg', 'file://disable-kgdb.cfg', d)} \
"

KERNEL_FEATURES_append_v1000 = " cfg/sound.scc"

COMPATIBLE_MACHINE_v1000 = "v1000"
