FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " \
     file://0003-configure-Allow-to-disable-demos-which-require-GLEW-.update.patch \
"
