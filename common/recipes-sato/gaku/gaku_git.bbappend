FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS_remove_amd = " gstreamer"
DEPENDS_append_amd = " gstreamer1.0"
RDEPENDS_${PN}_amd = "gstreamer1.0-plugins-base-audioconvert \
            gstreamer1.0-plugins-base-audioresample \
            gstreamer1.0-plugins-base-typefindfunctions"

RRECOMMENDS_${PN}_amd = "gstreamer1.0-plugins-good-id3demux \
               gstreamer1.0-plugins-base-vorbis \
               gstreamer1.0-plugins-base-alsa \
               gstreamer1.0-plugins-base-ogg \
               ${COMMERCIAL_AUDIO_PLUGINS}"

SRC_URI_append_amd = " file://upgrade-gstreamer.patch"
