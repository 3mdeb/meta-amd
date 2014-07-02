FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_baldeagle = " \
	    file://gpt_disklabel.cfg \
           "
SRC_URI_append_steppeeagle = " \
	    file://gpt_disklabel.cfg \
           "
