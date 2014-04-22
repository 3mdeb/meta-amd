PRINC := "${@int(PRINC) + 1}"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
	    file://enable-fma4-for-AMD-bdver3.patch \
           "
