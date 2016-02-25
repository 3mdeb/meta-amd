FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append_amd = " libvorbis libvdpau"

SRC_URI_append_amd = " file://0001-set_sdl_as_default_audio_output.patch"

# mplayer has a build issue with gcc-5.x
# which can be worked around by disabling theora
EXTRA_OECONF_remove_amd = "--enable-theora"
EXTRA_OECONF_append_amd = "--disable-theora"

# Clear blacklist if we want to include mplayer
UPSTREAM_BLACKLIST_VALUE := "${@d.getVarFlag('PNBLACKLIST', 'mplayer2', False)}"
PNBLACKLIST[mplayer2] = "${@bb.utils.contains('INCLUDE_MPLAYER', 'yes', '', '${UPSTREAM_BLACKLIST_VALUE}', d)}"
