FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_steppeeagle = "file://mullins_ce.bin \
			      file://mullins_me.bin \
			      file://mullins_mec.bin \
			      file://mullins_pfp.bin \
			      file://mullins_rlc.bin \
			      file://mullins_sdma1.bin \
			      file://mullins_sdma.bin \
			      file://mullins_uvd.bin \
			      file://mullins_vce.bin"
