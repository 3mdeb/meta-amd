require recipes-core/llvm/llvm.inc
require llvm3.7.0.inc

LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=4c0bc17c954e99fd547528d938832bfa"

DEPENDS += "zlib"
RDEPENDS_${PN} += "ncurses-terminfo"
PROVIDES += "llvm"

EXTRA_OECONF += "--enable-targets=x86_64,amdgpu"

SRC_URI = "\
	   git://llvm.org/git/llvm.git;branch=master;protocol=http \
	   file://0001-force-link-pass.o.patch \
	   file://0002-remove-extra-forward-slash-character-at-include-dire.patch \
	  "

S = "${WORKDIR}/git"

SRCREV = "e874345be4f5f26e063f0085c1fdde1f75009f53"
PV = "3.7.0"

PACKAGECONFIG ??= ""

do_configure_prepend() {
	# Drop "svn" suffix from version string
	sed -i 's/${PV}svn/${PV}/g' ${S}/configure
}
