FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "${@bb.utils.contains_any("DISTRO", "mel mel-lite", "file://04b33e21866412689f18b7ad6daf0a54d8f959a7.patch", "", d)}"
