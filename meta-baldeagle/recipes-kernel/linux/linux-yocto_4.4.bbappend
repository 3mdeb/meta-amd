FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_baldeagle += "	file://baldeagle-user-features.scc \
 				file://baldeagle-user-patches.scc \
				file://baldeagle_savedefconfig.cfg \
"

COMPATIBLE_MACHINE_baldeagle = "baldeagle"
