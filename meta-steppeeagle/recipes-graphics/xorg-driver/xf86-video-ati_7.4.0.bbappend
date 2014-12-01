FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	   file://0001-radeon-add-support-for-Mullins.patch \
	   file://0002-radeon-kms-add-Mullins-pci-ids.patch \
"

PATCHTOOL = "git"
