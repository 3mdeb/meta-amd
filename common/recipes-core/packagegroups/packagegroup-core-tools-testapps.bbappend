RDEPENDS_${PN}_remove_amd = " \
    gst-meta-video \
    gst-meta-audio \
    ${@base_contains("DISTRO", "mel-lite", "owl-video", "", d)} \
"

RDEPENDS_${PN}_append_amd = "${@base_contains("DISTRO", "mel-lite", "", " \
    gstreamer1.0-meta-video \
    gstreamer1.0-meta-audio \
", d)}"
