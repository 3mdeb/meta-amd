FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV_v1000 = "b8dd69e1b49a5c4c5c82e34f804a97f7448ff6c3"
LIC_FILES_CHKSUM_v1000 = "file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4"
PV_v1000 = "17.3.0+git${SRCPV}"

MESA_LLVM_RELEASE_v1000 = "6.0"

SRC_URI_v1000 = "\
			git://anongit.freedesktop.org/mesa/mesa;branch=master \
				file://0001-st-omx-enc-Correct-the-timestamping.patch \
				file://0002-st-omx-enc-Modularize-the-Encoding-task.patch \
				file://0003-st-omx-enc-Support-framerate-conversion.patch \
				file://0004-st-mesa-Reverting-patches-that-solved-perf-issues-wi.patch \
				file://0005-Added-the-workaround-fix-for-the-opengl-CTS-failure..patch \
				file://0006-st-omx-handle-invalid-timestamps-better-for-frc.patch \
				file://0007-Revert-st-mesa-Reverting-patches-that-solved-perf-is.patch \
"

MESA_CRYPTO_v1000 = ""

