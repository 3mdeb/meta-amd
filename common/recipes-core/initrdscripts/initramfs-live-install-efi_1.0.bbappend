FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_amd = " \
     file://0003-init-install-efi.sh-Don-t-set-quiet-kernel-option-in.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0004-init-install-efi.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0005-init-install-efi.sh-correctly-handle-mmc-device-chec.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0007-init-install-efi.sh-use-generated-partition-names-fo.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0010-init-install-efi.sh-etc-mtab-make-a-softlink-rather-.patch;striplevel=0;patchdir=${WORKDIR} \
"
