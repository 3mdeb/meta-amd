require recipes-core/llvm/llvm.inc
require llvm3.4.inc

LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=71df953c321b5b31ae94316a7fb6a7f3"

DEPENDS += "zlib ncurses"
EXTRA_OECONF += "--enable-zlib"

S = "${WORKDIR}/llvm-${PV}.src"

SRC_URI_append_libc-uclibc = " file://arm_fenv_uclibc.patch "
SRC_URI[md5sum] = "a20669f75967440de949ac3b1bad439c"
SRC_URI[sha256sum] = "17038d47069ad0700c063caed76f0c7259628b0e79651ce2b540d506f2f1efd7"

PACKAGECONFIG ??= ""
PACKAGECONFIG[r600] = "--enable-experimental-targets=R600,,,"
