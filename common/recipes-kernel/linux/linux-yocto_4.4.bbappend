require linux-yocto-common_4.4.inc

KBRANCH_amdx86 ?= "standard/base"
SRCREV_machine_amdx86 ?= "7d1401a0dd9bebfe49937ca7d9785972e0cc76d0"

SRC_URI_append_radeon += " \
	file://radeon-microcode.cfg \
	file://radeon-console.cfg \
	file://radeon-gpu-config.cfg \
"


