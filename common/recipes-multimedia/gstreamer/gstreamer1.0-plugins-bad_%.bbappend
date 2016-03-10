FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_amd += "file://fix_faad2_version_check.patch"

PACKAGECONFIG_append_amd = " faad"
