SRCREV = "48d3dbc8a0d3bfde88f46e402e530438f9317715"
PV = "7.3.99+git${SRCPV}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	   file://0001-radeon-add-support-for-Mullins.patch \
	   file://0002-radeon-kms-add-Mullins-pci-ids.patch \
"

PATCHTOOL = "git"
