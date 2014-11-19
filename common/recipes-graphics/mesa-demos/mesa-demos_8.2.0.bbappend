FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
DEPENDS_append_amd = " mesa-glut glew"
PACKAGECONFIG_append_amd = " glut"
EXTRA_OECONF_remove_amd = "--enable-glew --enable-glu"

SRC_URI_append_amd = " file://disable_GLEW_based_subdirs.patch \
"
