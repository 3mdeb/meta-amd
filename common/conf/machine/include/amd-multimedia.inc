GST_PACKAGES = " \
    gstreamer1.0-meta-x11-base \
    gstreamer1.0-meta-audio \
    gstreamer1.0-meta-debug \
    gstreamer1.0-meta-video \
    gstreamer1.0-omx \
    gstreamer-vaapi-1.0 \
"
IMAGE_INSTALL_append_mel += " ${@bb.utils.contains("DISTRO", "mel", "${GST_PACKAGES}", "", d)}"
