DESCRIPTION = "Sample application for AMD RTC driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://rtc-test.c;md5=cdf9bfd59714d20025056dbfaaf31134"

PR = "r1"
PV = "1.0"

SRC_URI = "file://rtc-test.c"

S = "${WORKDIR}"

TARGET_CC_ARCH += "${LDFLAGS}"

do_compile() {
	${CC} rtc-test.c -o rtc-test -lreadline
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 rtc-test ${D}${bindir}
}
