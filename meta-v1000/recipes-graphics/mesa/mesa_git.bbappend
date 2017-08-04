FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV_v1000 = "cb2a13e895adbbaa3a759abdcf6fbb89bb1523fe"
LIC_FILES_CHKSUM_v1000 = "file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4"
PV_v1000 = "17.2.0+git${SRCPV}"

MESA_LLVM_RELEASE_v1000 = "5.0"

SRC_URI_v1000 = "\
			git://anongit.freedesktop.org/mesa/mesa;branch=master \
				file://0001-change-va-max_entrypoints.patch \
				file://0002-st-va-Fix-leak-in-VAAPI-subpictures.patch \
				file://0003-radeonsi-unreference-vertex-buffers-when-destroying-.patch \
				file://0004-st-omx-enc-Correct-the-timestamping.patch \
				file://0005-st-omx-enc-Modularize-the-Encoding-task.patch \
				file://0006-st-omx-enc-Support-framerate-conversion.patch \
				file://0007-winsys-amdgpu-fix-a-deadlock-when-waiting-for-submis.patch \
				file://0008-util-u_queue-add-an-option-to-resize-the-queue-when-.patch \
				file://0009-radeonsi-prevent-a-deadlock-in-util_queue_add_job-wi.patch \
				file://0010-gallium-u_blitter-don-t-use-TXF-for-scaled-blits.patch \
				file://0011-radeonsi-gfx9-fix-crash-building-monolithic-merged-E.patch \
				file://0012-radeonsi-gfx9-fix-vertex-idx-in-ES-with-multiple-wav.patch \
				file://0013-radeonsi-gfx9-always-wrap-GS-and-TCS-in-an-if-block.patch \
				file://0014-radeonsi-reduce-max-threads-per-block-to-1024-on-gfx.patch \
				file://0015-radeon-vcn-move-message-buffer-to-vram-for-now.patch \
				file://0016-st-mesa-Reverting-patches-that-solved-perf-issues-wi.patch \
"

MESA_CRYPTO_v1000 = ""

