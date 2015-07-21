require recipes-core/llvm/llvm.inc
require llvm3.7.0.inc

LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=4c0bc17c954e99fd547528d938832bfa"

DEPENDS += "zlib"
RDEPENDS_${PN} += "ncurses-terminfo"
PROVIDES += "llvm"

EXTRA_OECONF += "--enable-zlib"
PACKAGECONFIG_append_amd = "r600"

SRC_URI = "\
	   git://llvm.org/git/llvm.git;branch=master;protocol=http \
	   file://0001-force-link-pass.o.patch \
	  "

S = "${WORKDIR}/git"

SRCREV = "ffc045ab802ea542aabf1f1f22f97cb8a0ad6cde"
PV = "3.7.0"

PACKAGECONFIG ??= ""
PACKAGECONFIG[r600] = "--enable-experimental-targets=R600,,,"

do_configure_prepend() {
	# Drop "svn" suffix from version string
	sed -i 's/${PV}svn/${PV}/g' ${S}/configure
}
