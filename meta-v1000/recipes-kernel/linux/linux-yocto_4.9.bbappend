require linux-yocto-v1000_4.9.inc

SRC_URI_append_v1000 += "file://v1000-standard-only.cfg"

KBRANCH_v1000 ?= "standard/base"
SRCREV_machine_v1000 ?= "81055b89bd32414ecaf95156ce9a5fa6643e530a"
