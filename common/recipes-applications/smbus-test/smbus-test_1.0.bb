DESCRIPTION = "Sample application for AMD SMBUS driver"
SECTION = "applications"
LICENSE = "BSD | GPLv2"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://smbus-test.c;md5=6e93b58b38eb7ba04529bb2b6c66ef70 \
                    file://i2c-dev.h;md5=11afa8583cd78137a63feb1a8b24cc51 \
                   "

PR = "r1"
PV = "1.0"

SRC_URI = "file://smbus-test.c \
           file://i2c-dev.h \
          "

S = "${WORKDIR}"

TARGET_CC_ARCH += "${LDFLAGS}"

do_compile() {
	${CC} smbus-test.c -o smbus-test -lreadline
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 smbus-test ${D}${bindir}
}
