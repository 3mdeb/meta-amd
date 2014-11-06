FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_steppeeagle = "file://MULLINS_ce.bin \
			      file://MULLINS_mec.bin \
			      file://MULLINS_rlc.bin \
			      file://MULLINS_me.bin \
			      file://MULLINS_pfp.bin \
			      file://MULLINS_sdma.bin \
"
