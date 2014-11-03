FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_amd = " file://disable-so-versioning.patch"

#
# The .so files populated by libomxil are not intended to be versioned and symlinked.
# Make sure they get packaged in the main package.
#
# Reorder the PACKAGES variable so FILES_${PN} is filled before FILES_${PN}-dev.
# This has been fixed in a more robust fashion in poky/master.
#
PACKAGES_amd := "${@oe_filter_out('${PN}-dev', '${PACKAGES}', d)} ${PN}-dev"
FILES_${PN}_append_amd = " ${libdir}/bellagio/*.so"

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
