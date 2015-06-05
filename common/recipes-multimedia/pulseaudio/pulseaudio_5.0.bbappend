FILESEXTRAPATHS_prepend_amd := "${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "${THISDIR}/${PN}:", d)}"

# These patches are already included in version 5.99.1
# in PA upstream so should be dropped after an upgrade.
SRC_URI_append_amd = " ${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "file://consolidate-startup-scripts.patch \
			 file://remove-kde-references.patch \
		         file://avoid-specifically-starting-PA-rely-on-autospawn.patch", d)}"

# Disable autospawning, so init manager can be used to control the
# daemon deterministically
SRC_URI_append_amd = " ${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "file://disable_autospawn_by_default.patch", d)}"
