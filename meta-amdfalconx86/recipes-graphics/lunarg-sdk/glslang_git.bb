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
LIC_FILES_CHKSUM = "file://glslang/Include/Types.h;beginline=1;endline=36;md5=6639a5f9543e833d71e2f4e4ff52f34b"

S = "${WORKDIR}/git"

SRCREV = "e4821e43c86d97bcf65fb07c1f70471b7102978d"
SRC_URI = "git://github.com/KhronosGroup/glslang \
           file://0001-CMakeLists.txt-obey-CMAKE_INSTALL_LIBDIR.patch"

FILES_${PN} += "${libdir}/*"

BBCLASSEXTEND = "native"

do_install_append() {
    # Some of the vulkan samples/test require these headers
    install -d ${D}${includedir}/SPIRV
    cp -f ${S}/SPIRV/GlslangToSpv.h ${D}${includedir}/SPIRV
    cp -f ${S}/SPIRV/Logger.h ${D}${includedir}/SPIRV
    cp -f ${S}/SPIRV/SPVRemapper.h ${D}${includedir}/SPIRV
    cp -f ${S}/SPIRV/spvIR.h ${D}${includedir}/SPIRV

    install -d ${D}${includedir}/glslang/Include
    cp -f ${S}/glslang/Include/*.h ${D}${includedir}/glslang/Include
    install -d ${D}${includedir}/glslang/Public
    cp -f ${S}/glslang/Public/*.h ${D}${includedir}/glslang/Public
    install -d ${D}${includedir}/glslang/MachineIndependent
    cp -f ${S}/glslang/MachineIndependent/Versions.h ${D}${includedir}/glslang/MachineIndependent
}
