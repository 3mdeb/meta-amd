PRINC := "${@int(PRINC) + 1}"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
	    file://switch_root.cfg \
           "
