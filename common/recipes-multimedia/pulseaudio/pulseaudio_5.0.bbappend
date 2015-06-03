FILESEXTRAPATHS_prepend_amd := "${THISDIR}/${PN}:"

# These patches are already included in version 5.99.1
# in PA upstream so should be dropped after an upgrade.
SRC_URI_append_amd = " file://consolidate-startup-scripts.patch \
		       file://remove-kde-references.patch \
		       file://avoid-specifically-starting-PA-rely-on-autospawn.patch \
"

SRC_URI_append_amd = " file://disable_autospawn_by_default.patch \
"

