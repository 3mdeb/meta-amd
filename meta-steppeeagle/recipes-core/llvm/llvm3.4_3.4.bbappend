FILESEXTRAPATHS_prepend_steppeeagle := "${THISDIR}/${PN}:"

SRC_URI_append_steppeeagle = " \
		file://0001-R600-SI-Add-processor-type-for-Mullins.patch \
"
