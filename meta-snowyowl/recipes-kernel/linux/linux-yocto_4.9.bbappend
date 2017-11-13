require linux-yocto-snowyowl_4.9.inc

MACHINE_FEATURES_remove = "alsa"
MACHINE_EXTRA_RRECOMMENDS_remove = "alsa-utils"

SRC_URI_append_snowyowl += "file://snowyowl-standard-only.cfg"

KBRANCH_snowyowl ?= "standard/base"
SRCREV_machine_snowyowl ?= "81055b89bd32414ecaf95156ce9a5fa6643e530a"

do_validate_branches_append() {
    # Droping configs related to sound generating spurious warnings
    sed -i '/kconf hardware snd_hda_intel.cfg/d' ${WORKDIR}/${KMETA}/features/sound/snd_hda_intel.scc
}
