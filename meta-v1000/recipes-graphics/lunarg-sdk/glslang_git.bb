SUMMARY = "An OpenGL and OpenGL ES shader front end and validator."
DESCRIPTION = "Glslang is the official reference compiler front end \
               for the OpenGL ES and OpenGL shading languages. It \
               implements a strict interpretation of the specifications \
               for these languages. It is open and free for anyone to use, \
               either from a command line or programmatically."
SECTION = "graphics"
HOMEPAGE = "https://www.khronos.org/opengles/sdk/tools/Reference-Compiler"

inherit cmake

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://glslang/Include/Types.h;beginline=1;endline=36;md5=9dbd36d87d27a0c98a6f4d72afaa9cf8"

S = "${WORKDIR}/git"

SRCREV = "2651ccaec8170b3257642b3c438f50dc4f181fdd"
SRC_URI = "git://github.com/KhronosGroup/glslang \
           file://0002-spirv-do-not-install-conflicting-headers.patch"

FILES_${PN} += "${libdir}/*"

BBCLASSEXTEND = "native nativesdk"
