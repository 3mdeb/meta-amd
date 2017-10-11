DESCRIPTION = "Sample application for AMD GPIO driver"
SECTION = "applications"
LICENSE = "BSD"
DEPENDS = "readline"
LIC_FILES_CHKSUM = "file://gpio-test.c;endline=29;md5=8e7a9706367d146e5073510a6e176dc2"

SRC_URI = "file://gpio-test.c \
           file://gpio-test.h \
          "

TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}"

do_compile() {
	${CC} gpio-test.c -o gpio-test -lreadline
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 gpio-test ${D}${bindir}
}
