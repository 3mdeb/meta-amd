DESCRIPTION = "A comprehensive collection of open source C++ examples for Vulkan(tm), \
		the new graphics and compute API from Khronos."
SECTION = "devel"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=dcf473723faabf17baa9b5f2207599d0"

RDEPENDS_${PN} = "libassimp-dev libxcb-dev"
DEPENDS = "libassimp"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = " \
	git://github.com/SaschaWillems/Vulkan;protocol=git;branch=master \
	file://001-Add-Install-Target.patch \
	"
SRC_URI[md5sum] = "ef270bedbfdd13d572612b91d73c898b"
SRC_URI[sha256sum] = "b702240f7c101056b7e41bbc4e90bf4b301bc295df54188a613d29599785d456"

SRCREV  = "fa18736ee5f35c42821fe58e7eebf58ff59558c4"

S = "${WORKDIR}/git"

inherit cmake

DEST = "${D}/opt/${PN}"

INSANE_SKIP_${PN} += "dev-deps"

FILES_${PN} = "/opt/${PN}/*"
