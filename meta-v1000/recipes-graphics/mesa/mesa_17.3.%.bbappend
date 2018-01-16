FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

MESA_LLVM_RELEASE_v1000 = "6.0"

SRC_URI_append_v1000 = " file://0001-st-omx-enc-Correct-the-timestamping.patch \
			file://0002-st-omx-enc-Modularize-the-Encoding-task.patch \
			file://0003-st-omx-enc-Support-framerate-conversion.patch \
			file://0004-st-mesa-Reverting-patches-that-solved-perf-issues-wi.patch \
			file://0005-Added-the-workaround-fix-for-the-opengl-CTS-failure..patch \
			file://0006-st-omx-handle-invalid-timestamps-better-for-frc.patch \
			file://0007-Revert-st-mesa-Reverting-patches-that-solved-perf-is.patch"