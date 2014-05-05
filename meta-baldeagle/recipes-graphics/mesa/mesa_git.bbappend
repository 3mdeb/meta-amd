FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "ad04e396faaddce926ee1146f0da12b30aee7b87"
PV = "10.0.4+git${SRCPV}"
DEPENDS += "libvdpau"
PACKAGECONFIG_append = " xvmc openvg gallium gallium-egl gallium-gbm r600"
PACKAGECONFIG_append += " gallium-llvm"
MESA_LLVM_RELEASE = "3.4"

# Install the demos onto the target
RRECOMMENDS_libgl-mesa += "mesa-demos"

SRC_URI += " \
	   file://0001-vl-vlc-add-remove-bits-function.patch \
	   file://0002-vl-vlc-add-function-to-limit-the-vlc-size.patch \
	   file://0003-vl-rbsp-add-H.264-RBSP-implementation.patch \
	   file://0004-st-omx-initial-OpenMAX-support.patch \
	   file://0005-st-omx-h264-fix-an-error-for-pic_order_cnt_type-1.patch \
	   file://0006-st-omx-h264-implement-support-for-field-decoding.patch \
	   file://0007-radeon-video-seperate-common-video-functions.patch \
	   file://0008-vl-add-H264-encoding-interface.patch \
	   file://0009-r600-video-disable-tilling-for-now.patch \
	   file://0010-radeon-winsys-add-vce-ring-support-to-winsys.patch \
	   file://0011-radeon-vce-initial-VCE-support.patch \
	   file://0012-st-omx-initial-OpenMAX-H264-encoder.patch \
	   file://0013-st-omx-enc-fix-eos-handling.patch \
	   file://0014-st-omx-enc-implement-scaling-configuration-support-v.patch \
	   file://0015-st-omx-enc-h264-fix-bitrate-bug-on-VCE-v2.0.patch \
	   file://0016-radeon-vce-revert-feedback-buffer-hack.patch \
	   file://0017-radeon-vce-Fixed-bitstream-frame-size-calculation-af.patch \
	   file://0018-radeonsi-omx-Makefile.am-fix-lib-omx-radeonsi-loadin.patch \
	   file://0019-st-omx-enc-fix-scaling-alignment-issue.patch \
	   file://0020-radeon-video-always-create-buffers-in-the-right-doma.patch \
	   file://0021-radeon-vce-flush-async.patch \
	   file://0022-radeon-vce-move-video-buffers-to-GTT-for-now.patch \
	   file://0023-st-omx-enc-remove-duplicate-scaling-alignment.patch \
	   file://0024-radeon-vce-implement-VCE-cropping-support.patch \
	   file://0025-st-omx-enc-user-separate-pipe-object-for-scale-and-t.patch \
	   file://0026-radeon-uvd-fix-feedback-buffer-handling-v2.patch \
	   file://0027-st-omx-enc-always-flush-the-transfer-pipe-before-enc.patch \
	   file://0029-glx-fix-the-default-values-for-GLXFBConfig-attributes.patch \
	   file://0030-glx-fix-the-GLXFBConfig-attrib-sort-priorities.patch \
           "

EXTRA_OECONF += "--disable-dri3 \
		 --enable-vdpau \
		 --enable-osmesa \
		 --enable-xa"

PACKAGES += "libxvmcr600-${PN}-dev"
FILES_libxvmcr600-${PN}-dev += "${libdir}/libXvMCr600.so \
                                ${libdir}/libXvMCr600.la"

PACKAGES += "libxvmcnouveau-${PN}-dev"
FILES_libxvmcnouveau-${PN}-dev += "${libdir}/libXvMCnouveau.so \
                                   ${libdir}/libXvMCnouveau.la"

PACKAGES += "libvdpau-${PN} libvdpau-${PN}-dev"
FILES_libvdpau-${PN}     += "${libdir}/vdpau/libvdpau*.so.*"
FILES_libvdpau-${PN}-dev += "${libdir}/vdpau/libvdpau*.so \
                             ${libdir}/vdpau/libvdpau*.la"
FILES_${PN}-dbg           += "${libdir}/vdpau/.debug"

PACKAGES += "libxatracker-${PN} libxatracker-${PN}-dev"
FILES_libxatracker-${PN} += "${libdir}/libxatracker.so.*"
FILES_libxatracker-${PN}-dev += "${includedir}/xa_tracker.h \
                                 ${includedir}/xa_composite.h \
                                 ${includedir}/xa_context.h \
                                 ${libdir}/pkgconfig/xatracker.pc \
                                 ${libdir}/libxatracker.so \
                                 ${libdir}/libxatracker.la \
                                 "
