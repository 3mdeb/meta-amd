FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
RDEPENDS_${PN}_append_amd = "libomx-mesa"

#
# This package should not have commercial license flags.
# There is discussion in the OE community about fixing this
# but in the meantime we'll explicitly remove it here.
#
LICENSE_FLAGS_remove = "commercial"

SRC_URI_append_amd = " file://0001-Added-NULL-pointer-check-for-failure-scenario.patch"

#
# The upstream sources expect that "make check" is run
# after "make install" and we have to jump through some
# extra hoops since we are cross building to avoid RPATH
# issues.
#
do_install_append_amd () {
    ln -sf ${D}${libdir}/libomxil-bellagio.a test/components/audio_effects/
    ln -sf ${D}${libdir}/libomxil-bellagio.a test/components/resource_manager/
    oe_runmake includedir=${D}${includedir} LDFLAGS="${LDFLAGS} -L." check
    install test/components/audio_effects/omxvolcontroltest ${D}${bindir}
    install test/components/audio_effects/omxaudiomixertest ${D}${bindir}
    install test/components/resource_manager/omxrmtest ${D}${bindir}
}

PACKAGES_prepend_amd = "${PN}-test "
FILES_${PN}-test_amd = "${bindir}/omxvolcontroltest ${bindir}/omxaudiomixertest ${bindir}/omxrmtest"

pkg_postinst_${PN}_amd () {
    if test -n "$D"; then
        exit 1
    else
        OMX_BELLAGIO_REGISTRY=${ROOT_HOME}/.omxregister ${bindir}/omxregister-bellagio -v
    fi
}
