FILESEXTRAPATHS_prepend_amd := "${THISDIR}/${PN}:"
SRC_URI_append_amd = "${@bb.utils.contains_any("DISTRO", "mel mel-lite", " file://0001-Avoid-conflicts-with-integer-width-macros-from-TS-18.patch", "", d)}"
