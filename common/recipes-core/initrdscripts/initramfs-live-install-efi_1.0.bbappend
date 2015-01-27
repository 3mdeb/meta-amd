FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
     file://0003-init-install-efi.sh-Give-names-to-the-partitions.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0004-init-install-efi.sh-Copy-existing-files-from-USB-boo.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0007-init-install-efi.sh-Don-t-set-quiet-kernel-option-in.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0009-init-install-efi.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0010-init-install-efi.sh-Switch-to-using-UUIDs.patch;striplevel=0;patchdir=${WORKDIR} \
"
