DEPENDS_append_amd = " libvorbis libvdpau"

# mplayer has a build issue with gcc-5.x
# which can be worked around by disabling theora
EXTRA_OECONF_remove_amd = "--enable-theora"
EXTRA_OECONF_append_amd = "--disable-theora"
