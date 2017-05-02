require linux-yocto-snowyowl_4.9.inc

SRC_URI_append_snowyowl += "file://snowyowl-standard-only.cfg"

KBRANCH_snowyowl ?= "standard/base"
SRCREV_machine_snowyowl ?= "81055b89bd32414ecaf95156ce9a5fa6643e530a"
