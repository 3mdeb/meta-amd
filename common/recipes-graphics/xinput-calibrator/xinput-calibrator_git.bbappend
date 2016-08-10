FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_amd = " file://add-geometry-input-when-calibrating.patch"
RDEPENDS_${PN}_append_amd = " xrandr bash"

do_install_append_amd() {
    # Do not install the boot time auto launcher
    rm -rf ${D}${sysconfdir}/xdg/autostart
}
