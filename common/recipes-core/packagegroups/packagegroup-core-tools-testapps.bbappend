RDEPENDS_${PN}_remove_amd = " \
    gst-meta-video \
    gst-meta-audio \
    ${@bb.utils.contains("DISTRO", "mel", "", "owl-video", d)} \
"

RDEPENDS_${PN}_append_amd = "${@bb.utils.contains("DISTRO", "mel", " \
    gstreamer1.0-meta-video \
    gstreamer1.0-meta-audio \
", "", d)}"
