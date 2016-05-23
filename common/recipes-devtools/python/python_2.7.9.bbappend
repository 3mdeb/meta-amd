FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " ${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", \
                       "file://0001-ensure-usage-of-native-modules-while-cross-compiling.patch", d)} \
                       file://0002-fix-assertion-of-device-name-to-be-slightly-more-len.patch \
"
