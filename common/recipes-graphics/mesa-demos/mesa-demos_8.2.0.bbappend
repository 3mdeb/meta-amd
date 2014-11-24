FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " file://disable_GLEW_based_subdirs.patch \
"
