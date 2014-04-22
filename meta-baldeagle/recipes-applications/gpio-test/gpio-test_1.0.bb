DESCRIPTION = "Sample application for AMD GPIO driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://gpio-test.c;md5=39a7f24d8634a2dcba930899b58b0c5b"

PR = "r1"
PV = "1.0"

SRC_URI = "file://gpio-test.c"

TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}"

do_compile() {
	${CC} gpio-test.c -o gpio-test -lreadline
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 gpio-test ${D}${bindir}
}
