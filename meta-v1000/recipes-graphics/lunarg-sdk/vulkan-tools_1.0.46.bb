SUMMARY = "Vulkan Tools"
DESCRIPTION = "This project provides vktrace capture/replay \
               tool, Intel Ilo sample driver and other layer \
               tools and driver tests."
SECTION = "graphics"
HOMEPAGE = "https://github.com/LunarG/VulkanTools"
DEPENDS = "vulkan-loader-layers xcb-util-keysyms"

RDEPENDS_${PN} = "${PN}-layer-libs"

inherit cmake python3native

REQUIRED_DISTRO_FEATURES = "x11"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=99c647ca3d4f6a4b9d8628f757aad156"

S = "${WORKDIR}/git"

SRCREV = "acc7e724948d0e2389b1fa95d1281be749efab81"
SRC_URI = "git://github.com/LunarG/VulkanTools;branch=sdk-${PV} \
           file://0001-json-fix-layer-paths.patch \
           file://0002-vktrace-do-not-link-to-internal-loader.patch \
           file://0003-CMakeLists-do-not-use-hardcoded-source-paths.patch \
           file://0004-CMakeLists-add-include-path-so-Xlib.h-is-found-as-ne.patch \
           file://0005-vktrace_layer-force-linker-flags.patch \
           file://0006-CMakeList-only-search-for-jsoncpp-when-needed.patch \
           file://0007-layersvt-obey-CMAKE_INSTALL_LIBDIR.patch \
           file://0008-CMakeLists-only-deploy-headers-when-needed.patch"

EXTRA_OECMAKE = " \
    -DBUILD_LOADER=0 \
    -DBUILD_TESTS=0 \
    -DBUILD_LAYERS=0 \
    -DBUILD_LAYERSVT=1 \
    -DBUILD_DEMOS=0 \
    -DBUILD_VKTRACE=1 \
    -DBUILD_VKJSON=0 \
    -DBUILD_WSI_WAYLAND_SUPPORT=0 \
    -DBUILD_WSI_MIR_SUPPORT=0 \
    -DBUILD_VIA=0 \
"
PACKAGES =+ "${PN}-layer-libs"
FILES_${PN}-layer-libs = "${libdir}/libVkLayer_*.so"

INSANE_SKIP_${PN}-layer-libs = "ldflags"

do_install_append() {
    install -d ${D}${bindir}
    cp -f ${B}/vktrace/vktrace ${D}${bindir}
    cp -f ${B}/vktrace/vkreplay ${D}${bindir}

    install -d ${D}${libdir}
    cp -f ${B}/vktrace/libVkLayer_vktrace_layer.so ${D}${libdir}

    install -d ${D}${sysconfdir}/vulkan/explicit_layer.d
    cp -f ${S}/layersvt/${HOST_OS}/*.json ${D}${sysconfdir}/vulkan/explicit_layer.d
    cp -f ${S}/vktrace/vktrace_layer/${HOST_OS}/*.json ${D}${sysconfdir}/vulkan/explicit_layer.d
}
