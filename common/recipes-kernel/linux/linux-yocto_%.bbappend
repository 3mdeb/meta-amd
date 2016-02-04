FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Add keyring fix to all that are not mel
SRC_URI += "${@bb.utils.contains("DISTRO", "mel", "", "file://kernel-keyring-CVE-2016-0728.patch", d)}"
