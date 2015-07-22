FILESEXTRAPATHS_prepend_amd := "${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "${THISDIR}/${PN}:", d)}"

# Disable autospawning, so init manager can be used to control the
# daemon deterministically
SRC_URI_append_amd = " ${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "file://disable_autospawn_by_default.patch", d)}"
