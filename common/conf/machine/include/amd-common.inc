IMAGE_INSTALL_append += " \
    bc \
"

GST_PACKAGES = " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11',' \
    gstreamer1.0-meta-x11-base \
    gstreamer1.0-meta-audio \
    gstreamer1.0-meta-debug \
    gstreamer1.0-meta-video \
    gstreamer1.0-omx \
    gstreamer1.0-vaapi', '', d)}"

IMAGE_INSTALL_append_mel += " ${@bb.utils.contains("DISTRO", "mel", "${GST_PACKAGES}", "", d)}"
