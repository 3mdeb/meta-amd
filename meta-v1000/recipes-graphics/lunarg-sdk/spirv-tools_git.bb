SUMMARY = "SPIR-V Tools"
DESCRIPTION = "SPIR-V is a binary intermediate language for representing \
               graphical-shader stages and compute kernels for multiple \
               Khronos APIs, such as OpenCL, OpenGL, and Vulkan."
SECTION = "graphics"
HOMEPAGE = "https://www.khronos.org/registry/spir-v"

inherit cmake python3native

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

S = "${WORKDIR}/git"
SPIRV_HEADERS_LOCATION = "${S}/external/spirv-headers"
HEADERS_VERSION = "1.1"

SRCREV_spirv-tools = "5834719fc17d4735fce0102738b87b70255cfd5f"
SRCREV_spirv-headers = "061097878467b8e040fbf153a837d844ef9f9f96"
SRC_URI = "git://github.com/KhronosGroup/SPIRV-Tools;protocol=http;name=spirv-tools \
           git://github.com/KhronosGroup/SPIRV-Headers;name=spirv-headers;destsuffix=${SPIRV_HEADERS_LOCATION} \
           file://0002-spirv-lesspipe.sh-allow-using-generic-shells.patch"

do_install_append() {
    if test -d ${SPIRV_HEADERS_LOCATION}/include/spirv/${HEADERS_VERSION}; then
        install -d ${D}/${includedir}/SPIRV
        install -m 0644 ${SPIRV_HEADERS_LOCATION}/include/spirv/${HEADERS_VERSION}/* ${D}/${includedir}/SPIRV
    fi
}
