DESCRIPTION = "Sample application for AMD Watchdog driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://watchdog-test.c;md5=47ff70acbf47e0bf894330dee1143414"

PR = "r1"
PV = "1.0"

SRC_URI = "file://watchdog-test.c"

S = "${WORKDIR}"

TARGET_CC_ARCH += "${LDFLAGS}"

do_compile() {
	${CC} watchdog-test.c -o watchdog-test -lreadline
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 watchdog-test ${D}${bindir}
}
