FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_steppeeagle += "	file://steppeeagle-user-features.scc \
 				file://steppeeagle-user-patches.scc \
				file://steppeeagle_savedefconfig.cfg \
"

COMPATIBLE_MACHINE_steppeeagle = "steppeeagle"
