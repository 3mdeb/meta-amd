FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_amd = " \
     file://0004-init-install-efi.sh-Don-t-set-quiet-kernel-option-in.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0005-init-install-efi.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0006-init-install-efi.sh-Switch-to-using-static-device-pa.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0009-init-install-efi.sh-uniquely-identify-boot-device.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0010-init-install-efi.sh-handle-mmc-device-as-installation-media.patch;striplevel=0;patchdir=${WORKDIR} \
"
