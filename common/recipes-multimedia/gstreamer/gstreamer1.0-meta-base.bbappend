RDEPENDS_gstreamer1.0-meta-video_append_amd = " \
    gstreamer1.0-plugins-good-video4linux2 \
    gstreamer1.0-plugins-good-isomp4 \
    gstreamer1.0-plugins-good-deinterlace \
    gstreamer1.0-plugins-good-audioparsers \
    gstreamer1.0-plugins-good-id3demux \
    gstreamer1.0-plugins-good-videomixer \
"

#
# Remove gst-plugins-ugly from DEPENDS unless explicitly enabled
# in the COMMERCIAL_ or AMD_ plugins.
#
# Done using anonymous python to make sure it runs after the DEPENDS
# variable is fully parsed from the upstream bb file.
#
COMMERCIAL_PLUGINS = "${COMMERCIAL_AUDIO_PLUGINS} ${COMMERCIAL_VIDEO_PLUGINS} ${AMD_PLUGINS}"
DEPENDS_BAD = "${@'' if 'bad' in COMMERCIAL_PLUGINS.split('-') else 'gstreamer1.0-plugins-bad'}"
python __anonymous () {
    d.setVar("DEPENDS_remove_amd", d.getVar("DEPENDS_BAD", True))
}
