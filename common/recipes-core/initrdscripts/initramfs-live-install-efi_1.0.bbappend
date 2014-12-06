FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
     file://0004-init-install-efi.sh-Don-t-set-quiet-kernel-option-in.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0005-init-install-efi.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0006-init-install-efi.sh-Switch-to-using-UUIDs.patch;striplevel=0;patchdir=${WORKDIR} \
"
