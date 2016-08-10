FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amd = " file://0002-fix-assertion-of-device-name-to-be-slightly-more-len.patch"
