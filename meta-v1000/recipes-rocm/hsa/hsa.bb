SUMMARY = "AMD Heterogeneous System Architecture HSA"
DESCRIPTION = "This package includes the user-mode API \
               interfaces and libraries necessary for host \
               applications to launch compute kernels to \
               available HSA kernel agent."

LICENSE = "NCSA"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=abc754edcbe650f4f548eb4efc3cf8d5"

RDEPENDS_${PN} = "libhsakmt"

SRC_URI = "file://hsa.tar.gz"
SRC_URI[md5sum] = "385631b37d8fc208a2c8843e263e7de2"

S = "${WORKDIR}/hsa"

# Skip configure and compile
do_configure[noexec] = "1"
do_compile[noexec] = "1"

INSANE_SKIP_${PN} += "already-stripped build-deps ldflags"

do_install () {
    # Install the binary components
    install -d ${D}${bindir}
    cp -r ${S}/bin/* ${D}${bindir}
    install -d ${D}${libdir}
    cp -r ${S}/lib/* ${D}${libdir}
    install -d ${D}${includedir}
    cp -r ${S}/include/* ${D}${includedir}
}
