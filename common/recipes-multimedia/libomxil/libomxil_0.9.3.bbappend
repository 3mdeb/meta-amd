RDEPENDS_${PN}_append_amd = "libomx-mesa"

#
# This package should not have commercial license flags.
# There is discussion in the OE community about fixing this
# but in the meantime we'll explicitly remove it here.
#
LICENSE_FLAGS_remove = "commercial"

#
# The upstream sources expect that "make check" is run
# after "make install" and we have to jump through some
# extra hoops since we are cross building to avoid RPATH
# issues.
#
do_install_append_amd () {
    oe_runmake includedir=${D}${includedir} LDFLAGS="${LDFLAGS} -L${D}${libdir}" check
    install test/components/audio_effects/omxvolcontroltest ${D}${bindir}
    install test/components/audio_effects/omxaudiomixertest ${D}${bindir}
    install test/components/resource_manager/omxrmtest ${D}${bindir}
}

INSANE_SKIP_${PN}-test = "rpaths"

PACKAGES_prepend_amd = "${PN}-test "
FILES_${PN}-test_amd = "${bindir}/omxvolcontroltest ${bindir}/omxaudiomixertest ${bindir}/omxrmtest"

pkg_postinst_${PN}_amd () {
    if test -n "$D"; then
        exit 1
    else
        OMX_BELLAGIO_REGISTRY=${ROOT_HOME}/.omxregister ${bindir}/omxregister-bellagio -v
    fi
}
