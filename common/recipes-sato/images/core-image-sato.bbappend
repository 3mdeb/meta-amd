require conf/machine/include/amd-common.inc

IMAGE_INSTALL_append_amdgpu = " mesa-demos"
IMAGE_INSTALL_append_radeon = " mesa-demos"
IMAGE_INSTALL_append_v1000 = " opencl"

VULKAN_COMPONENTS = ""
CODEXL_COMPONENTS = ""

VULKAN_COMPONENTS_amdfalconx86 = "glslang spirv-tools vulkan-loader-layers vulkan-tools vulkan-samples"
CODEXL_COMPONENTS_amdfalconx86 = "codexl codexl-examples"

VULKAN_COMPONENTS_v1000 = "amdvlk glslang spirv-tools vulkan-loader-layers vulkan-tools vulkan-samples rgp"

IMAGE_INSTALL_append = "${@bb.utils.contains("INCLUDE_VULKAN", "yes", " ${VULKAN_COMPONENTS}", "", d)} \
                        ${@bb.utils.contains("INCLUDE_CODEXL", "yes", " ${CODEXL_COMPONENTS}", "", d)} \
                       "
