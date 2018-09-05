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

SRCREV = "b94505e03c1169e745bc9a67697a8f6943c18c8f"
SRCREV_loader = "1fede1a6b8d6103cc9fcacb567747aa2af167849"
SRC_URI = "git://github.com/LunarG/VulkanTools;branch=sdk-${PV} \
           git://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers;branch=sdk-${PV};name=loader;destsuffix=${S}/submodules/Vulkan-LoaderAndValidationLayers \
           file://0002-vktrace-do-not-link-to-internal-loader.patch \
           file://0005-vktrace_layer-force-linker-flags.patch \
           file://0001-CMakeLists-add-include-paths-so-Xlib-and-XCB-are-fou.patch \
           file://0002-layersvt-drop-device_sim-as-we-don-t-have-jsoncpp-fo.patch \
           file://0003-CMakeLists.txt-use-a-fixed-header-for-spirv_commit.patch \
"

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
    -DINSTALL_LVL_FILES=0 \
    -DBUILD_ICD=0 \
"
PACKAGES =+ "${PN}-layer-libs"
FILES_${PN}-layer-libs = "${libdir}/libVkLayer_*.so"

INSANE_SKIP_${PN}-layer-libs = "ldflags"

# Conditional building of vktraceviewer
QTBITS ?= "${@bb.utils.contains('BBFILE_COLLECTIONS', 'qt5-layer', 'cmake_qt5', '',d)}"
inherit ${QTBITS}
DEPENDS += "${@base_conditional('QTBITS', '', '', 'libxcb qtsvg', d)}"
RDEPENDS_${PN}_append = " ${@base_conditional('QTBITS', '', '', 'qtsvg', d)}"
do_install_append() {
    if [ "${QTBITS}" != ""  ]
    then
        install ${B}/vktrace/vktraceviewer ${D}${bindir}
    fi
}

