FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_baldeagle = " \
	    file://switch_root.cfg \
	    file://losetup.cfg \
           "
SRC_URI_append_steppeeagle = " \
	    file://switch_root.cfg \
	    file://losetup.cfg \
           "
