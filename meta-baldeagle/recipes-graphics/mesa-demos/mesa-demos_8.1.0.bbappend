FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
EXTRA_OECONF += "--with-system-data-files"
PACKAGECONFIG[glut] = "--with-glut=${STAGING_EXECPREFIXDIR},--without-glut,"
DEPENDS_baldeagle += "mesa-glut glew"
PACKAGECONFIG_append_baldeagle = " glut"

SRC_URI += " \
           file://0001-mesa-demos-Use-DEMOS_DATA_DIR-to-locate-data-files.patch \
           file://0001-mesa-demos-Add-missing-data-files.patch \
"

do_install_append () {
    install -m 0644 ${S}/src/perf/*.frag \
                    ${S}/src/perf/*.vert \
                    ${S}/src/glsl/*.frag \
                    ${S}/src/glsl/*.vert \
                    ${S}/src/glsl/*.geom \
                    ${S}/src/glsl/*.glsl ${D}${datadir}/${BPN}
}
