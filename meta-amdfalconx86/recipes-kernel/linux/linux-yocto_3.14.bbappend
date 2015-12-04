require linux-yocto-amd.inc

KBRANCH_amdfalconx86 ?= "standard/common-pc-64/base"
SRCREV_machine_amdfalconx86 ?= "c100e8665052051487a17169748c457829d3f88c"

# do no print configuration warnings on build console
KCONF_AUDIT_LEVEL = "0"
KCONF_BSP_AUDIT_LEVEL = "0"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-standard.scc \
				file://amdfalconx86-gpu-config.cfg \
"
