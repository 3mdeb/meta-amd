FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
DEPENDS_append_amd = " mesa-glut glew"
PACKAGECONFIG_append_amd = " glut"

SRC_URI += " \
           file://0001-opengles2-es2tri-add-precision-qualifier-to-the-frag.patch \
"
