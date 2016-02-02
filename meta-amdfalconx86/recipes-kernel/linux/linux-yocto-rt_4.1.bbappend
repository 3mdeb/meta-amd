KBRANCH_amdfalconx86 = "standard/preempt-rt/base"
SRCREV_machine_amdfalconx86 = "3188436876d5eaff8d48f82064367d4a65c3aa97"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-preempt-rt.scc \
"

require linux-yocto-amd-4.1.inc
