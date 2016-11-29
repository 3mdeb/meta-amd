require conf/machine/include/amd-common.inc

IMAGE_INSTALL_append_amdgpu = " mesa-demos"
IMAGE_INSTALL_append_radeon = " mesa-demos"

VULKAN_COMPONENTS_amdfalconx86 = "glslang spirv-tools vulkan-loader-layers vulkan-tools vulkan-samples"
CODEXL_COMPONENTS = "codexl codexl-examples"

IMAGE_INSTALL_append = "${@' ${VULKAN_COMPONENTS}' if bb.utils.to_boolean('${INCLUDE_VULKAN}') else ''} \
                        ${@' ${CODEXL_COMPONENTS}' if bb.utils.to_boolean('${INCLUDE_CODEXL}') else ''} \
                       "
