FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_amd = " \
     file://0001-init-install.sh-Don-t-set-quiet-kernel-option-in-ins.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0002-init-install.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0006-init-install.sh-correctly-handle-mmc-device-check.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0008-init-install.sh-use-generated-partition-names-for-UU.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0009-init-install.sh-etc-mtab-make-a-softlink-rather-than.patch;striplevel=0;patchdir=${WORKDIR} \
"
