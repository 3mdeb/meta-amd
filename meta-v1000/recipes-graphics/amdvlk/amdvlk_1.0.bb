DESCRIPTION = "AMD Vulkan ICD Library"
LICENSE = "BSD"
RDEPENDS_${PN} = "libdrm vulkan-loader-layers"

LIC_FILES_CHKSUM = "file://amd_icd64.json;md5=169a0ec488fc9361f17883a5abdc5265"

SRC_URI = "file://amdvlk64.so \
	   file://amd_icd64.json \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/${sysconfdir}/vulkan/icd.d
    install -m 0644 ${S}/amd_icd64.json ${D}/${sysconfdir}/vulkan/icd.d/
    install -vd ${D}/${libdir}
    install -m 0755 ${S}/amdvlk64.so ${D}/${libdir}
}

INSANE_SKIP_${PN} += "already-stripped ldflags file-rdeps"

FILES_${PN} += "${libdir}"
FILES_SOLIBSDEV = ""
