SUMMARY = "OpenCL components for development on AMD platforms"
DESCRIPTION = "This package provides binary runtime/development \
               components for utilizing OpenCL on AMD platforms."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS_${PN} = "hsa ${PN}-bitcodes ${PN}-amd-drivers"

SRC_URI = "file://opencl.tar.gz"
SRC_URI[md5sum] = "977cf66239988d166b2a542cad23487b"

S = "${WORKDIR}/opencl"

# Skip configure and compile
do_configure[noexec] = "1"
do_compile[noexec] = "1"

PACKAGES =+ "${PN}-bitcodes ${PN}-amd-drivers"

FILES_${PN}-bitcodes = "${libdir}/bitcode/*"
FILES_${PN}-amd-drivers = "${libdir}/libcltrace.so \
                           ${libdir}/libamdocl64.so"

INSANE_SKIP_${PN} += "already-stripped build-deps ldflags"
INSANE_SKIP_${PN}-amd-drivers += "ldflags file-rdeps"

do_install () {
    # Install the binary components
    install -d ${D}${bindir}
    cp -r ${S}/bin/x86_64/* ${D}${bindir}
    install -d ${D}${libdir}
    cp -r ${S}/lib/x86_64/* ${D}${libdir}
    install -d ${D}${includedir}
    cp -r ${S}/include/* ${D}${includedir}
    install -d ${D}${sysconfdir}/OpenCL
    cp -r ${S}/etc/* ${D}${sysconfdir}/OpenCL
}
