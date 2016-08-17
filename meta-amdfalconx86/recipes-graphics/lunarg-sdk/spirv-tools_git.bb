SUMMARY = "SPIR-V Tools"
DESCRIPTION = "SPIR-V is a binary intermediate language for representing \
               graphical-shader stages and compute kernels for multiple \
               Khronos APIs, such as OpenCL, OpenGL, and Vulkan."
SECTION = "graphics"
HOMEPAGE = "https://www.khronos.org/registry/spir-v"

inherit cmake python3native

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ce523927d7bcd789d6c3af579d03ad73"

S = "${WORKDIR}/git"
SPIRV_HEADERS_LOCATION = "${S}/external/spirv-headers"
HEADERS_VERSION = "1.1"

SRCREV_spirv-tools = "6c61bf2dfadf70ab5fe1b0fb918ba03b7afa2396"
SRCREV_spirv-headers = "3814effb879ab5a98a7b9288a4b4c7849d2bc8ac"
SRC_URI = "git://github.com/KhronosGroup/SPIRV-Tools;protocol=http;name=spirv-tools \
           git://github.com/KhronosGroup/SPIRV-Headers;name=spirv-headers;destsuffix=${SPIRV_HEADERS_LOCATION} \
           file://0001-obey-CMAKE_INSTALL_LIBDIR.patch"

do_install_append() {
    if test -d ${SPIRV_HEADERS_LOCATION}/include/spirv/${HEADERS_VERSION}; then
        install -d ${D}/${includedir}/SPIRV
        install -m 0644 ${SPIRV_HEADERS_LOCATION}/include/spirv/${HEADERS_VERSION}/* ${D}/${includedir}/SPIRV
    fi
}
