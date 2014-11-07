DESCRIPTION = "These binaries provide kernel support for AMD radeon GPUs"
SECTION = "kernel"
LICENSE = "Proprietary"

SRC_URI = "file://BONAIRE_ce.bin \
	   file://BONAIRE_rlc.bin \
	   file://BONAIRE_mc.bin \
	   file://BONAIRE_sdma.bin \
	   file://BONAIRE_me.bin \
	   file://BONAIRE_smc.bin \
	   file://BONAIRE_mec.bin \
	   file://BONAIRE_uvd.bin \
	   file://BONAIRE_pfp.bin \
	   file://BONAIRE_vce.bin \
	   file://HAINAN_ce.bin \
	   file://HAINAN_smc.bin \
	   file://HAINAN_mc.bin \
	   file://HAINAN_vce.bin \
	   file://HAINAN_me.bin \
	   file://HAINAN_pfp.bin \
	   file://HAINAN_rlc.bin \
	   file://KAVERI_pfp.bin \
	   file://KAVERI_rlc.bin \
	   file://KAVERI_ce.bin \
	   file://KAVERI_sdma.bin \
	   file://KAVERI_me.bin \
	   file://KAVERI_mec.bin \
	   file://LICENSE.radeon \
"

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
	install -v -m 0644 ${S}/*.bin ${D}/lib/firmware/radeon/
}

FILES_${PN} = "/lib/firmware/*"
