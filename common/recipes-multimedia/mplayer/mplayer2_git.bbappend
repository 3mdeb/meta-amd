FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append_amd = " libvorbis libvdpau"

SRC_URI_append_amd = " file://0001-set_sdl_as_default_audio_output.patch"
