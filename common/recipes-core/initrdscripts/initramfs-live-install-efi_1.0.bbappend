FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
     file://0001-init-install-efi.sh-improve-hard-drive-searching-pro.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0002-init-install-efi.sh-fix-to-handle-the-boot-partition.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0003-init-install-efi.sh-Give-names-to-the-partitions.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0004-init-install-efi.sh-Copy-existing-files-from-USB-boo.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0007-init-install-efi.sh-Don-t-set-quiet-kernel-option-in.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0009-init-install-efi.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0010-init-install-efi.sh-Switch-to-using-UUIDs.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0012-init-install-efi.sh-Verify-sys-based-files-exist-bef.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0014-init-install-efi.sh-Skip-CDROM-devices-during-probe.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0016-init-install-efi.sh-Strip-partition-number-from-live.patch;striplevel=0;patchdir=${WORKDIR} \
"
