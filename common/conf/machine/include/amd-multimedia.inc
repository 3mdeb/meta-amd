GST_PACKAGES = " \
    gstreamer1.0-meta-x11-base \
    gstreamer1.0-meta-audio \
    gstreamer1.0-meta-debug \
    gstreamer1.0-meta-video \
    gstreamer1.0-omx \
"
IMAGE_INSTALL_append_mel += " ${@base_contains("DISTRO", "mel-lite", "", "${GST_PACKAGES}", d)}"
