#
# Workaround grub boot failure by building for core2
# rather than or btver2(steppeeagle)
#
TUNE_CCARGS_append_amd += "-march=core2"

#
# Make sure to use our modified cfg file
# This fixes an issue where Grub would sometimes use
# the wrong grub.cfg at boot time.
#
FILESPATH_prepend := "${THISDIR}/files:"

SRC_URI_append_mel = " file://0001-grub-core-kern-efi-mm.c-grub_efi_finish_boot_service.patch \
                       file://0002-grub-core-kern-efi-mm.c-grub_efi_get_memory_map-Neve.patch"
