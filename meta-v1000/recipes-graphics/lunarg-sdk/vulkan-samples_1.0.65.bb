SUMMARY = "Vulkan Samples"
DESCRIPTION = "This project is a collection \
               of Vulkan C++ sample applications."
SECTION = "graphics"
HOMEPAGE = "https://github.com/LunarG/VulkanSamples"
DEPENDS = "vulkan-loader-layers glslang"

inherit cmake python3native

REQUIRED_DISTRO_FEATURES = "x11"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=99c647ca3d4f6a4b9d8628f757aad156"

S = "${WORKDIR}/git"

SRCREV = "b2a179cda8bb688dd0eaa82c08f864c1dfc3a98a"
SRC_URI = "git://github.com/LunarG/VulkanSamples;branch=sdk-${PV} \
           file://0002-install-samples.patch"

EXTRA_OECMAKE = " \
    -DBUILD_LOADER=0 \
    -DBUILD_TESTS=0 \
    -DBUILD_LAYERS=0 \
    -DBUILD_DEMOS=0 \
    -DBUILD_VKJSON=0 \
    -DBUILD_WSI_MIR_SUPPORT=0 \
    -DBUILD_WSI_WAYLAND_SUPPORT=0 \
    -DINSTALL_LVL_FILES=0 \
"
