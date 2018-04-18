FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " file://0001-test-components-fix-linking-issue.patch"

RDEPENDS_${PN}_append_amd = " libomx-mesa"
RDEPENDS_${PN}-test_append_amd = " bash"

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
    oe_runmake includedir=${D}${includedir} LDFLAGS="${LDFLAGS}" check
    install test/components/audio_effects/omxvolcontroltest ${D}${bindir}
    install test/components/audio_effects/omxaudiomixertest ${D}${bindir}
    install test/components/resource_manager/omxrmtest ${D}${bindir}
}

PACKAGES_prepend_amd = "${PN}-test "
FILES_${PN}-test_amd = "${bindir}/omxvolcontroltest ${bindir}/omxaudiomixertest ${bindir}/omxrmtest"

pkg_postinst_ontarget_${PN}_amd () {
    OMX_BELLAGIO_REGISTRY=${ROOT_HOME}/.omxregister ${bindir}/omxregister-bellagio -v
}
