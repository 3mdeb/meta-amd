FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Add keyring fix to all that are not mel or mel-lite
SRC_URI += "${@bb.utils.contains_any("DISTRO", "mel mel-lite", "", "file://kernel-keyring-CVE-2016-0728.patch", d)}"
