DESCRIPTION = "Sample application for AMD SPI driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://spirom-test.c;md5=c6d80587d583668ffbfb5828abd58878 \
                    file://spirom.h;md5=56f117ed31b82b02182c7a491364d112 \
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
