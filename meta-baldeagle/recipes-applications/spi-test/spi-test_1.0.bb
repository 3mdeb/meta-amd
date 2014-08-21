DESCRIPTION = "Sample application for AMD SPI driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://spirom-test.c;md5=3065341fac5fc1255711c219f00f7324 \
                    file://spirom.h;md5=dad84d1bbdd9852dde1fdf1ea3a014d6 \
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
