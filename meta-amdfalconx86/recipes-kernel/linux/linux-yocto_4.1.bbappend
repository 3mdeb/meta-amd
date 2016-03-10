KBRANCH_amdfalconx86 = "standard/base"
SRCREV_machine_amdfalconx86 = "dd6492b44151164242718855d6c9eebbf0018eac"

require linux-yocto-amd-4.1.inc

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-gpu-config.cfg \
				file://amdfalconx86-standard-only.cfg \
"
