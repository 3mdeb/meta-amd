SUMMARY = "Vulkan Ecosystem Components - Loader and Validation Layers"
DESCRIPTION = "Vulkan is a new generation graphics and compute API that \
               provides high-efficiency, cross-platform access to modern \
               GPUs used in a wide variety of devices from PCs and \
               consoles to mobile phones and embedded platforms."
SECTION = "graphics"
HOMEPAGE = "https://www.khronos.org/vulkan"
DEPENDS = "bison-native libx11 libxcb glslang glslang-native spirv-tools \
            libice libxext libsm libxrandr"

RDEPENDS_${PN} = "${PN}-layer-libs libxcb-sync libxcb-present libxcb-dri3"

inherit cmake python3native

REQUIRED_DISTRO_FEATURES = "x11"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=99c647ca3d4f6a4b9d8628f757aad156"

S = "${WORKDIR}/git"

SRCREV = "1fede1a6b8d6103cc9fcacb567747aa2af167849"
SRC_URI = "git://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers;branch=sdk-${PV} \
           file://0001-CMakeLists-add-include-path-so-Xlib.h-is-found-as-ne.patch \
           file://0002-demos-CMakeLists.txt-install-demos.patch \
           file://0003-CMakeLists.txt-use-a-fixed-header-for-spirv_commit.patch \
           file://0004-layer_validation_tests-include-math.h.patch \
           file://0005-demos-cube-use-absolute-location-for-data-files.patch"

EXTRA_OECMAKE = " \
    -DCUSTOM_GLSLANG_BIN_ROOT=1 \
    -DGLSLANG_BINARY_ROOT=${STAGING_DIR_HOST}/usr \
    -DCUSTOM_SPIRV_TOOLS_BIN_ROOT=1 \
    -DSPIRV_TOOLS_BINARY_ROOT=${STAGING_DIR_HOST}/usr \
    -DBUILD_TESTS=1 \
    -DBUILD_WSI_MIR_SUPPORT=0 \
    -DBUILD_WSI_WAYLAND_SUPPORT=0 \
"

PACKAGES =+ "${PN}-layer-libs"
FILES_${PN}-layer-libs = "${libdir}/libVkLayer_*.so"

FILES_SOLIBSDEV = ""
FILES_${PN} += "${libdir}/libvulkan.so \
                ${datadir}"
INSANE_SKIP_${PN} = "dev-so"

do_install_append() {
    mv ${D}${bindir}/cube ${D}${bindir}/cube-vulkan
    mv ${D}${bindir}/cubepp ${D}${bindir}/cubepp-vulkan

    install -D ${B}/demos/lunarg.ppm ${D}${datadir}/vulkan-data/lunarg.ppm

    # drop the spirv_tools_commit_id.h from installation
    rm -f ${D}${includedir}/vulkan/spirv_tools_commit_id.h
}
