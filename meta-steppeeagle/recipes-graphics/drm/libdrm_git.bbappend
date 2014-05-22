FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "e6ec4c88519da05eccc05ed2ae7ff20277e3672a"
PV = "2.4.53+git${SRCPV}"

SRC_URI += " \
	    file://0001-radeon-add-Mullins-chip-family.patch \
	    file://0002-radeon-add-Mullins-pci-ids.patch \
	    "

PATCHTOOL = "git"
