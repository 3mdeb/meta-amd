FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_amd = " file://add-geometry-input-when-calibrating.patch"
RDEPENDS_${PN}_append_amd = " xrandr bash"
