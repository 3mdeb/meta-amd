DESCRIPTION = "These binaries provide kernel support for AMD radeon GPUs"
SECTION = "kernel"
LICENSE = "Proprietary"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI = "file://*.bin"

LIC_FILES_CHKSUM = "file://LICENSE.radeon;md5=07b0c31777bd686d8e1609c6940b5e74"

S = "${WORKDIR}"

# Since, no binaries are generated for a specific target, 
# inherit allarch to simply populate prebuilt binaries
inherit allarch

do_compile() {
	:
}

do_install() {
	install -v -m 444 -D ${S}/LICENSE.radeon ${D}/lib/firmware/radeon/LICENSE.radeon
	install -v -d ${D}/lib/firmware/amd-ucode/
	install -v -m 0644 ${S}/microcode_amd_fam15h.bin ${D}/lib/firmware/amd-ucode/
	install -v -m 0644 ${S}/*.bin ${D}/lib/firmware/radeon/
	rm -f ${D}/lib/firmware/radeon/microcode_amd_fam15h.bin
}

FILES_${PN} = "/lib/firmware/*"
