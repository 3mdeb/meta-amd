FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amdfalconx86 += " \
	   ${@bb.utils.contains("RT_KERNEL_AMDFALCONX86", "yes", "", "file://0001-adjust-gstomx.conf-for-amdgpu.patch", d) } \
	   ${@bb.utils.contains("RT_KERNEL_AMDFALCONX86", "yes", "", "file://0001-gstomxvideoenc-use-scaling-default-macro-s.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMDFALCONX86", "yes", "", "file://0002-gstomxvideoenc-fix-srcpad-caps-when-scaling-property.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMDFALCONX86", "yes", "", "file://0003-gstomxvideoenc-add-fix-timestamp-property.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMDFALCONX86", "yes", "", "file://0004-gstomxvideoenc-add-force-keyframe-period-property.patch", d)} \
	  "
