FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_baldeagle = "file://microcode_amd_fam15h.bin"

do_install_append_baldeagle() {
	install -v -d ${D}/lib/firmware/amd-ucode/
	install -v -m 0644 ${S}/microcode_amd_fam15h.bin ${D}/lib/firmware/amd-ucode/
	rm -f ${D}/lib/firmware/radeon/microcode_amd_fam15h.bin
}
