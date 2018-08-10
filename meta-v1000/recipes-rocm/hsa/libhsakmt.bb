SUMMARY = "ROCt Library"
DESCRIPTION = "This package includes the user-mode API interfaces \
               used to interact with the ROCk driver. Currently \
               supported agents include only the AMD/ATI Fiji family \
               of discrete GPUs."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=b1afa13daf74f4073c4813368bc1b1b0"

RDEPENDS_${PN} = "libpci numactl"

SRC_URI = "file://libhsakmt.tar.gz"
SRC_URI[md5sum] = "42cd36a0dd85f892fc0d334cc92a91d7"

S = "${WORKDIR}/libhsakmt"

# Skip configure and compile
do_configure[noexec] = "1"
do_compile[noexec] = "1"

INSANE_SKIP_${PN} += "already-stripped build-deps"

do_install () {
    # Install the binary components
    install -d ${D}${libdir}
    cp -r ${S}/lib/* ${D}${libdir}
    install -d ${D}${includedir}
    cp -r ${S}/include/* ${D}${includedir}
}
