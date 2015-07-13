SUMMARY = "Library for handling OpenGL function pointer management"

DESCRIPTION = "Epoxy is a library for handling OpenGL function pointer \
management for you. It hides the complexity of dlopen(), dlsym(), \
glXGetProcAddress(), eglGetProcAddress(), etc. from the app developer, \
with very little knowledge needed on their part. They get to read GL specs \
and write code using undecorated function names like glCompileShader()."

HOMEPAGE = "https://github.com/anholt/libepoxy"
SECTION = "x11/libs"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://COPYING;md5=58ef4c80d401e07bd9ee8b6b58cf464b"

SRC_URI = "http://crux.nu/files/libepoxy-${PV}.tar.gz"
SRC_URI[md5sum] = "12d6b7621f086c0c928887c27d90bc30"
SRC_URI[sha256sum] = "42c328440f60a5795835c5ec4bdfc1329e75bba16b6e22b3a87ed17e9679e8f6"

S = "${WORKDIR}/libepoxy-${PV}"

DEPENDS += "util-macros virtual/libx11 virtual/egl"

inherit autotools pkgconfig gettext
