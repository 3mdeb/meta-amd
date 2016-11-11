FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

#
# Remove plugins-bad from DEPENDS as it is
# not strictly needed.
#
DEPENDS_remove_amd = "gstreamer1.0-plugins-bad"

#
# Remove the patch as it is not needed with the new SRCREV we are using
#
SRC_URI_remove_amd = "file://0001-omx-fixed-type-error-in-printf-call.patch"

SRC_URI_append_amd = " \
	   file://0001-gstomxvideodec-fix-multithreads-negotiation-problem-.patch \
	   file://0002-gstomxvideodec-remove-dead-code.patch \
	   file://0003-gstomxvideodec-simplify-_find_nearest_frame.patch \
	   file://0004-gstomxvideoenc-simplify-_find_nearest_frame.patch \
	   file://0005-omx-improve-tunneling-support.patch \
	   file://0006-omx-add-tunneling-support-between-decoder-and-encode.patch \
	   file://0007-gstomxvideoenc-implement-scaling-configuration-suppo.patch \
	   file://0008-configure-fix-first-run-of-autogen-automake.patch \
	   file://0009-omxvideodec-fix-startup-race-condition.patch \
	   file://0010-omxvideoenc-fix-startup-race-condition.patch \
	   file://0011-omx-fix-two-serious-message-handling-bugs.patch \
	   file://0012-gstomxvideoenc-implement-capture-configuration-suppo.patch \
	   file://0013-gstomxvideoenc-add-capture-geometry-support.patch \
	   file://0014-gstomxvideoenc-reduce-shutdown-timeout-for-tunnellin.patch \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0001-gstomxvideoenc-use-scaling-default-macro-s.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0002-gstomxvideoenc-fix-srcpad-caps-when-scaling-property.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0003-gstomxvideoenc-add-fix-timestamp-property.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0004-gstomxvideoenc-add-force-keyframe-period-property.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0005-gstomxvideoenc-Add-new-property-to-set-framerate.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0006-gstomxvideoenc-Update-GstBuffer-fields-on-FRC.patch", d)} \
	   ${@bb.utils.contains("RT_KERNEL_AMD", "yes", "", "file://0001-adjust-gstomx.conf-for-mesa.patch", d)} \
	  "

SRCREV_gst-omx_amd = "c44cd849400b90f5f4b1f4f429278d9685b1daca"
SRCREV_common_amd = "1a07da9a64c733842651ece62ddefebedd29c2da"

PV .= "+git${SRCPV}"

#
# This package should not have commercial license flags.
# There is discussion in the OE community about fixing this
# but in the meantime we'll explicitly remove it here.
#
LICENSE_FLAGS_remove = "commercial"
