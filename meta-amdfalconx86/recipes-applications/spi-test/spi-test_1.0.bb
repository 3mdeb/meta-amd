DESCRIPTION = "Sample application for AMD SPI driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://spirom-test.c;md5=8dac97fc0527a3c7721fc257dd110445 \
                    file://spirom.h;md5=1990f1f1e7a82115c354152bed83df52 \
                   "

PR = "r1"
PV = "1.0"

SRC_URI = "file://spirom-test.c \
           file://spirom.h \
          "

S = "${WORKDIR}"

TARGET_CC_ARCH += "${LDFLAGS}"

do_compile() {
	${CC} spirom-test.c -o spirom-test -lreadline
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 spirom-test ${D}${bindir}
}
