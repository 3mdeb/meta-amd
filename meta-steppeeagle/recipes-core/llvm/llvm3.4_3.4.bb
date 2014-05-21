require recipes-core/llvm/llvm.inc
require recipes-core/llvm/llvm3.inc
require llvm3.4.inc

LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=71df953c321b5b31ae94316a7fb6a7f3"

DEPENDS += "zlib"
EXTRA_OECONF += "--enable-zlib"

S = "${WORKDIR}/llvm-${PV}"

SRC_URI += "file://0001-R600-SI-Add-processor-type-for-Mullins.patch"

SRC_URI_append_libc-uclibc = " file://arm_fenv_uclibc.patch "
SRC_URI[md5sum] = "46ed668a1ce38985120dbf6344cf6116"
SRC_URI[sha256sum] = "25a5612d692c48481b9b397e2b55f4870e447966d66c96d655241702d44a2628"

PACKAGECONFIG ??= ""
PACKAGECONFIG[r600] = "--enable-experimental-targets=R600,,,"
