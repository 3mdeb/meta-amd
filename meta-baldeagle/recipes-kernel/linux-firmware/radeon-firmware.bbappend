FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI_append_baldeagle = "file://microcode_amd_fam15h.bin \
			    file://KAVERI_pfp.bin \
			    file://KAVERI_rlc.bin \
			    file://KAVERI_ce.bin \
			    file://KAVERI_sdma.bin \
			    file://KAVERI_me.bin \
			    file://KAVERI_mec.bin \
"

do_install_append_baldeagle() {
	install -v -d ${D}/lib/firmware/amd-ucode/
	install -v -m 0644 ${S}/microcode_amd_fam15h.bin ${D}/lib/firmware/amd-ucode/
	rm -f ${D}/lib/firmware/radeon/microcode_amd_fam15h.bin
}
