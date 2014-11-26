FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " \
     file://fix-glew.pc-install.update.patch \
"
