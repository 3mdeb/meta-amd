DESCRIPTION = "These binaries provide kernel support for newer AMD GPUs"
SECTION = "kernel"
LICENSE = "Firmware-amd"

SRC_URI = "file://carrizo_ce.bin \
	   file://carrizo_me.bin \
	   file://carrizo_mec2.bin \
	   file://carrizo_mec.bin \
	   file://carrizo_pfp.bin \
	   file://carrizo_rlc.bin \
	   file://carrizo_sdma1.bin \
	   file://carrizo_sdma.bin \
	   file://carrizo_uvd.bin \
	   file://carrizo_vce.bin \
	   file://stoney_ce.bin \
	   file://stoney_me.bin \
	   file://stoney_mec.bin \
	   file://stoney_pfp.bin \
	   file://stoney_rlc.bin \
	   file://stoney_sdma.bin \
	   file://stoney_uvd.bin \
	   file://stoney_vce.bin \
	   file://LICENSE \
	  "

LIC_FILES_CHKSUM = "file://LICENSE;md5=07b0c31777bd686d8e1609c6940b5e74"

S = "${WORKDIR}"

# Since, no binaries are generated for a specific target, 
# inherit allarch to simply populate prebuilt binaries
inherit allarch

do_compile() {
	:
}

do_install() {
	install -v -m 444 -D ${S}/LICENSE ${D}/lib/firmware/amdgpu/LICENSE
	install -v -m 0644 ${S}/*.bin ${D}/lib/firmware/amdgpu
}

FILES_${PN} = "/lib/firmware/*"
