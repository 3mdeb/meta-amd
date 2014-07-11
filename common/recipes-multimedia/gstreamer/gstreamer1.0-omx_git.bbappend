FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

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
	  "

SRCREV_amd = "c44cd849400b90f5f4b1f4f429278d9685b1daca"

PV .= "+git${SRCPV}"

#
# This package should not have commercial license flags.
# There is discussion in the OE community about fixing this
# but in the meantime we'll explicitly remove it here.
#
LICENSE_FLAGS_remove = "commercial"

GSTREAMER_1_0_OMX_CORE_NAME_amd = "${libdir}/libomxil-bellagio.so.0"
