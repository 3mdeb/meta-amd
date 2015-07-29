FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amdfalconx86 += " \
	   ${@bb.utils.contains("RT_KERNEL_AMDFALCONX86", "yes", "", "file://0001-adjust-gstomx.conf-for-amdgpu.patch", d)} \
	  "
