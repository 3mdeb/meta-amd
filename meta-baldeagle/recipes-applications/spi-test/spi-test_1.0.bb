DESCRIPTION = "Sample application for AMD SPI driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://spirom-test.c;md5=a8b8f295bacb7eaffb0981efe09ca1bb \
                    file://spirom.h;md5=332ef940b1cb318fc8ecd9b1ba5940be \
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
