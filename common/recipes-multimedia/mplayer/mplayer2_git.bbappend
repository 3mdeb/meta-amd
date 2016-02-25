FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append_amd = " libvorbis libvdpau"

SRC_URI_append_amd = " file://0001-set_sdl_as_default_audio_output.patch \
                       file://0001-demux_ogg-partially-port-libtheora-glue-code-to-Theo.patch"

# Clear blacklist if we want to include mplayer
UPSTREAM_BLACKLIST_VALUE := "${@d.getVarFlag('PNBLACKLIST', 'mplayer2', False)}"
PNBLACKLIST[mplayer2] = "${@bb.utils.contains('INCLUDE_MPLAYER', 'yes', '', '${UPSTREAM_BLACKLIST_VALUE}', d)}"
