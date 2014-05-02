#
# Workaround grub boot failure by building for core2
# rather than bdver3(baldeagle) or btver2(steppeeagle)
#
# Still need to determine why this is necessary but
# in the meantime this will get us a bootable system.
#
TUNE_CCARGS_append_steppeeagle += "-march=core2"
TUNE_CCARGS_append_baldeagle += "-march=core2"
