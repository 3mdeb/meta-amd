require linux-yocto-amd.inc

KBRANCH_amdfalconx86 ?= "standard/preempt-rt/base"
SRCREV_machine_amdfalconx86 ?= "baad552ea168dc31db31f0be188edefaa28a4aec"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-preempt-rt.scc \
"
