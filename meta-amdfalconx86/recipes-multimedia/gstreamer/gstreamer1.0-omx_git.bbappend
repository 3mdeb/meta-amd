FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amdfalconx86 += " \
	   file://0001-adjust-gstomx.conf-for-amdgpu.patch \
	  "
