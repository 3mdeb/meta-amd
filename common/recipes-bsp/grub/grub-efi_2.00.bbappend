#
# Workaround grub boot failure by building for core2
# rather than bdver3(baldeagle) or btver2(steppeeagle)
#
TUNE_CCARGS_append_amd += "-march=core2"

#
# Make sure to use our modified cfg file
# This fixes an issue where Grub would sometimes use
# the wrong grub.cfg at boot time.
#
FILESPATH_prepend := "${THISDIR}/files:"
