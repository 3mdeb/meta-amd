FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS_remove_amd = " gstreamer gst-plugins-base"
DEPENDS_append_amd = " gstreamer1.0 gstreamer1.0-plugins-base"
RDEPENDS_${PN}_amd = "gstreamer1.0-meta-base"
RRECOMMENDS_${PN}_amd = "gstreamer1.0-meta-audio gstreamer1.0-meta-video"

SRC_URI_append_amd = " file://upgrade-gstreamer.patch"
