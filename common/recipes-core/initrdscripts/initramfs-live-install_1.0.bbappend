FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
     file://0005-init-install.sh-Copy-existing-files-from-USB-boot-in.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0006-init-install.sh-Don-t-set-quiet-kernel-option-in-ins.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0008-init-install.sh-Add-a-second-prompt-to-install.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0011-init-install.sh-Switch-to-using-UUIDs.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0013-init-install.sh-Verify-sys-based-files-exist-before-.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0015-init-install.sh-Skip-CDROM-devices-during-probe.patch;striplevel=0;patchdir=${WORKDIR} \
     file://0017-init-install.sh-Strip-partition-number-from-live_dev.patch;striplevel=0;patchdir=${WORKDIR} \
"
