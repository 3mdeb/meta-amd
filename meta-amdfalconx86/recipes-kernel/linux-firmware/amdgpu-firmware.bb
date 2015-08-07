DESCRIPTION = "These binaries provide kernel support for newer AMD GPUs"
SECTION = "kernel"
LICENSE = "Proprietary"

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
	install -v -m 444 -D ${S}/LICENSE.radeon ${D}/lib/firmware/amdgpu/LICENSE.radeon
	install -v -m 0644 ${S}/*.bin ${D}/lib/firmware/amdgpu
}

FILES_${PN} = "/lib/firmware/*"
