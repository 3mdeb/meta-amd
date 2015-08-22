FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_amd = " \
	    file://enable-fma4-for-AMD-bdver3.patch \
           "
