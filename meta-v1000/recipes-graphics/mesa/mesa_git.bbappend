FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV_v1000 = "733422e53c8758ce3f63db2109929339259681d8"
LIC_FILES_CHKSUM_v1000 = "file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4"
PV_v1000 = "17.3.0+git${SRCPV}"

MESA_LLVM_RELEASE_v1000 = "6.0"

SRC_URI_v1000 = "\
			git://anongit.freedesktop.org/mesa/mesa;branch=master \
				file://0001-st-omx-enc-Correct-the-timestamping.patch \
				file://0002-st-omx-enc-Modularize-the-Encoding-task.patch \
				file://0003-st-omx-enc-Support-framerate-conversion.patch \
				file://0004-st-mesa-Reverting-patches-that-solved-perf-issues-wi.patch \
"

MESA_CRYPTO_v1000 = ""

