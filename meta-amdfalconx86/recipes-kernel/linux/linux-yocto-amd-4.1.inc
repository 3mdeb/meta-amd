FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				file://amdfalconx86.cfg \
				file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-extra-config.cfg \
"

COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"
