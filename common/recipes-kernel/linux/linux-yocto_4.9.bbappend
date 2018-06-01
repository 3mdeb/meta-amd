require linux-yocto-common_4.9.inc
KBRANCH_amdx86 ?= "standard/base"
SRCREV_machine_amdx86 ?= "81055b89bd32414ecaf95156ce9a5fa6643e530a"
SRC_URI_append_amdx86 = " file://x86-asm-Move-status-from-thread_struct-to-thread_inf-linux-yocto.patch"
