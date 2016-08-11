DESCRIPTION = "Sample application for AMD SPI driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://spirom-test.c;md5=57b0b983cd8e62737e6ee55f5528a421 \
                    file://spirom.h;md5=8de0c535224dbd8ecd2f40ef29c15d0a \
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
