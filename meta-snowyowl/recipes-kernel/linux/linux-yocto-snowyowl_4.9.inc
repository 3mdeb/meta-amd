FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_snowyowl += "file://snowyowl-user-features.scc \
    file://snowyowl-user-patches.scc \
    file://snowyowl.cfg \
    file://snowyowl-user-config.cfg \
    file://snowyowl-extra-config.cfg \
    file://amd-xgbe.cfg \
    file://amd-ccp.cfg \
    file://kvm.cfg \
    file://afalg.cfg \
"

COMPATIBLE_MACHINE_snowyowl = "snowyowl"
