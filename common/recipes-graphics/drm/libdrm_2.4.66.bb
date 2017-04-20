SUMMARY = "Userspace interface to the kernel DRM services"
DESCRIPTION = "The runtime library for accessing the kernel DRM services.  DRM \
stands for \"Direct Rendering Manager\", which is the kernel portion of the \
\"Direct Rendering Infrastructure\" (DRI).  DRI is required for many hardware \
accelerated OpenGL drivers."
HOMEPAGE = "http://dri.freedesktop.org"
SECTION = "x11/base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://xf86drm.c;beginline=9;endline=32;md5=c8a3b961af7667c530816761e949dc71"
PROVIDES = "drm"
DEPENDS = "libpthread-stubs udev libpciaccess freetype libxext cairo fontconfig libxrender libpng pixman"

SRC_URI_amd = "http://dri.freedesktop.org/libdrm/${BP}.tar.bz2 \
               file://0001-tests-also-install-tests-app.patch \
               file://0004-amdgpu-drop-address-patching-logics.patch \
               file://0005-amdgpu-validate-user-memory-for-userptr.patch \
               file://0006-amdgpu-add-semaphore-support.patch \
               file://0008-amdgpu-list-each-entry-safely-for-sw-semaphore-when-.patch \
               file://0046-amdgpu-fix-for-submition-with-no-ibs.patch \
               file://0001-intel-kbl-Add-Kabylake-PCI-ids.patch \
               file://0002-Fix-memory-leak-with-drmModeGetConnectorCurrent.patch \
               file://0003-configure.ac-disable-annoying-warning-Wmissing-field.patch \
               file://0007-tests-amdgpu-add-semaphore-test.patch \
               file://0009-amdgpu-Add-new-symbols-to-amdgpu-symbols-check.patch \
               file://0010-radeon-Pass-radeon_bo_open-flags-to-the-DRM_RADEON_G.patch \
               file://0011-xf86drm-Bound-strstr-to-the-allocated-data.patch \
               file://0012-configure.ac-don-t-detect-disabled-options-dependenc.patch \
               file://0013-kmstest-Use-util_open.patch \
               file://0014-tests-add-fsl-dcu-drm-to-modules.patch \
               file://0015-tests-util-Fixup-util_open-parameter-order.patch \
               file://0016-tests-Include-sys-select.h.patch \
               file://0017-tests-Include-poll.h-rather-than-sys-poll.h.patch \
               file://0018-tests-kmstest-inverse-the-order-of-LDADD-libraries.patch \
               file://0019-vc4-Add-the-DRM-header-file.patch \
               file://0020-util-Add-support-for-vc4.patch \
               file://0021-vc4-Add-headers-and-.pc-files-for-VC4-userspace-deve.patch \
               file://0022-amdgpu-add-libdrm-as-private-requirement-dependency.patch \
               file://0023-radeon-add-libdrm-to-Requires.private.patch \
               file://0024-libkms-add-libdrm-to-Requires.private.patch \
               file://0025-android-enable-building-static-version-of-libdrm.patch \
               file://0026-amdgpu-add-the-interface-of-waiting-multiple-fences.patch \
               file://0027-amdgpu-tests-add-multi-fence-test-in-base-test.patch \
               file://0028-amdgpu-add-query-for-aperture-va-range.patch \
               file://0029-amdgpu-Implement-SVM-v2.patch \
               file://0030-amdgpu-SVM-test-v2.patch \
               file://0031-amdgpu-Implement-multiGPU-SVM-support-v2.patch \
               file://0032-tests-amdgpu-Add-test-for-multi-GPUs-SVM-test-v3.patch \
               file://0033-tests-amdgpu-Add-verbose-outputs-v2.patch \
               file://0034-amdgpu-Free-uninit-vamgr_32-in-theoretically-correct.patch \
               file://0035-amdgpu-vamgr_32-can-be-a-struct-instead-of-a-pointer.patch \
               file://0036-amdgpu-vamgr-can-be-a-struct-instead-of-a-pointer.patch \
               file://0037-tests-amdgpu-add-the-heap-info-for-query.patch \
               file://0038-amdgpu-reserve-SVM-range-explicitly-by-clients-v3.patch \
               file://0039-amdgpu-expose-the-AMDGPU_GEM_CREATE_NO_EVICT-flag.patch \
               file://0040-amdgpu-add-query-amdgpu-capability-defination.patch \
               file://0041-amdgpu-add-query-amdgpu-pinning-memory-capability-de.patch \
               file://0042-amdgpu-add-amdgpu_query_capability-interface.patch \
               file://0043-amdgpu-add-amdgpu_find_bo_by_cpu_mapping-interface.patch \
               file://0044-amdgpu-support-alloc-va-from-range.patch \
               file://0045-tests-amdgpu-add-alloc-va-from-range-test.patch \
               file://0047-tests-amdgpu-move-va_range_test-above-svm_test.patch \
               file://0048-amdgpu-add-the-function-to-get-the-marketing-name.patch \
               file://0049-tests-amdgpu-remove-none-amdgpu-devices-for-hybrid-G.patch \
               file://0050-amdgpu-tests-Fiji-VCE-is-one-instance.patch \
               file://0052-amdgpu-hybrid-update-the-gpu-marketing-name-table.patch \
               file://0053-Hybrid-Version-16.30.2.patch \
               file://0054-tests-amdgpu-add-interface-to-adapt-firmware-require.patch \
               file://0055-tests-amdgpu-adapt-to-new-polaris10-11-uvd-fw.patch \
               file://0056-amdgpu-change-max-allocation.patch \
               file://0057-amdgpu-fix-print-format-error-V2.patch \
               file://0058-Hybrid-Version-16.30.3.patch \
               file://0059-drm-fix-multi-GPU-drmGetDevices-only-return-one-devi.patch \
               file://0061-amdgpu-add-bo-handle-to-hash-table-when-cpu-mapping.patch \
               file://0062-amdgpu-cs_wait_fences-now-can-return-the-first-signa.patch \
               file://0065-Hybrid-Version-16.30.4.patch \
               file://0066-amdgpu-add-marketing-name-for-RX480-RX470.patch \
               file://0068-Hybrid-Version-16.40.1.patch \
               file://0069-Hybrid-Version-16.40.2.patch \
               file://0070-amdgpu-add-amdgpu_bo_inc_ref-function.patch \
               file://0071-Hybrid-Version-16.40.3.patch \
               file://0072-amdgpu-add-marketing-name-for-RX460.patch \
               file://0073-amdgpu-va-allocation-may-fall-to-the-range-outside-o.patch \
               file://0074-drm-fix-a-bug-in-va-range-allocation.patch \
               file://0077-amdgpu-Make-amdgpu_get_auth-to-non-static.patch \
               file://0078-amdgpu-Add-interface-amdgpu_get_fb_id.patch \
               file://0079-amdgpu-Add-interface-amdgpu_get_bo_from_fb_id.patch \
               file://0080-amdgpu-tests-Add-the-test-case-for-amdgpu_get_fb_id-.patch \
               file://0081-Hybrid-Version-16.40.4.patch \
               file://0082-amdgpu-Fix-memory-leak-in-amdgpu_get_fb_id.patch \
               file://0083-amdgpu-Fix-memory-leak-in-amdgpu_get_bo_from_fb_id.patch \
               file://0084-drm-Fix-multi-GPU-drmGetDevice-return-wrong-device.patch \
               file://0085-drm-fix-multi-GPU-drmFreeDevices-memory-leak.patch \
               file://0086-drm-add-marketing-names.patch \
               file://0087-Hybrid-Version-16.40.5.patch \
               file://0088-drm-add-marketing-name.patch \
               file://0089-Hybrid-Version-16.40.6.patch \
               file://0090-amdgpu-change-AMDGPU_GEM_CREATE_NO_EVICT-flag-defini.patch \
               file://0092-drm-add-marketing-names.patch \
               file://0095-drm-update-marketing-names.patch \
               file://0097-drm-add-marketing-name.patch \
               file://0099-amdgpu-add-the-copyright-and-macros-for-the-asic-id-.patch \
               file://0100-Hybrid-Version-16.40.7.patch \
               file://0101-drm-change-the-marketing-name.patch \
               file://0103-amdgpu-expose-the-AMDGPU_GEM_CREATE_VRAM_CLEARED-fla.patch \
               file://0104-drm-amdgpu-add-freesync-ioctl-defines.patch \
               file://0106-amdgpu-move-hybrid-specific-ioctl-to-the-end.patch \
               file://0108-amdgpu-tests-add-Polaris12-support-for-cs-test.patch \
               file://0109-amdgpu-tests-remove-debug-info-in-cs-test.patch \
               file://0110-drm-amdgpu-move-freesync-ioctl-to-hybrid-specific-ra.patch \
               file://0112-Hybrid-Version-16.50.0.patch \
               file://0113-Hybrid-Version-16.50.1.patch \
               file://0114-amdgpu-add-more-capability-query.patch \
               file://0115-amdgpu-implement-direct-gma.patch \
               file://0116-tests-amdgpu-add-direct-gma-test.patch \
               file://0117-Hybrid-Version-16.50.2.patch \
               file://0118-amdgpu-add-SI-support.patch \
               file://0119-amdgpu-add-vram-memory-info.patch \
               file://0120-tests-amdgpu-add-vram-memory-info-test.patch \
               file://0121-amdgpu-add-info-about-vram-and-gtt-total-size.patch \
               file://0122-amdgpu-add-info-about-vram-and-gtt-max-allocation-si.patch \
               file://0123-amdgpu-unify-memory-query-info-interface.patch \
               file://0124-amdgpu-remove-redundant-wrong-marketing-name.patch \
               file://0125-amdgpu-add-new-semaphore-support.patch \
               file://0126-amdgpu-new-ids-flag-for-preempt.patch \
               file://0127-amdgpu-sync-amdgpu_drm.h-with-the-kernel.patch \
"
SRC_URI[md5sum] = "c6809c48538d6e5999588832045ff014"
SRC_URI[sha256sum] = "79cb8e988749794edfb2d777b298d5292eff353bbbb71ed813589e61d2bc2d76"

inherit autotools pkgconfig

EXTRA_OECONF += "--disable-cairo-tests \
                 --enable-omap-experimental-api \
                 --enable-install-test-programs \
                 --disable-manpages \
                 --disable-valgrind \
		 --enable-amdgpu \
		 --enable-radeon \
                "

ALLOW_EMPTY_${PN}-drivers = "1"
PACKAGES =+ "${PN}-tests ${PN}-drivers ${PN}-radeon ${PN}-nouveau ${PN}-omap \
             ${PN}-intel ${PN}-exynos ${PN}-kms ${PN}-freedreno ${PN}-amdgpu"

RRECOMMENDS_${PN}-drivers = "${PN}-radeon ${PN}-nouveau ${PN}-omap ${PN}-intel \
                             ${PN}-exynos ${PN}-freedreno ${PN}-amdgpu"

FILES_${PN}-tests = "${bindir}/dr* ${bindir}/mode* ${bindir}/*test"
FILES_${PN}-radeon = "${libdir}/libdrm_radeon.so.*"
FILES_${PN}-nouveau = "${libdir}/libdrm_nouveau.so.*"
FILES_${PN}-omap = "${libdir}/libdrm_omap.so.*"
FILES_${PN}-intel = "${libdir}/libdrm_intel.so.*"
FILES_${PN}-exynos = "${libdir}/libdrm_exynos.so.*"
FILES_${PN}-kms = "${libdir}/libkms*.so.*"
FILES_${PN}-freedreno = "${libdir}/libdrm_freedreno.so.*"
FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"

do_install_append_amd() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
}
