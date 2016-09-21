DESCRIPTION = "Package group targeting gaming components for AMD platforms"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PR = "r0"

inherit packagegroup

LUNARG_SDK_COMPONENTS = "glslang spirv-tools vulkan-loader-layers vulkan-tools vulkan-samples"
CODEXL_COMPONENTS = "codexl codexl-examples"

RDEPENDS_${PN} += "\
    ${LUNARG_SDK_COMPONENTS} \
    ${CODEXL_COMPONENTS} \
"
