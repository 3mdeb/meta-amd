RDEPENDS_${PN}_remove_amd = " \
    gst-meta-video \
    gst-meta-audio \
    ${@base_contains("DISTRO", "mel", "", "owl-video", d)} \
"

RDEPENDS_${PN}_append_amd = "${@base_contains("DISTRO", "mel", " \
    gstreamer1.0-meta-video \
    gstreamer1.0-meta-audio \
", "", d)}"
