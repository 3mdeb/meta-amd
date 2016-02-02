require linux-yocto-amd-4.1.inc

KBRANCH_amdfalconx86 = "standard/base"
SRCREV_machine_amdfalconx86 = "788dfc9859321c09f1c58696bf8998f90ccb4f51"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-standard.scc \
				file://amdfalconx86-gpu-config.cfg \
"
