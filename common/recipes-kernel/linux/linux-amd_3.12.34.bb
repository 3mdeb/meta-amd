DESCRIPTION = "Linux Kernel v3.12.34"
SECTION = "kernel"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

inherit kernel cml1-config

SRC_URI = "https://www.kernel.org/pub/linux/kernel/v3.x/linux-${PV}.tar.xz;name=kernel \
 	   file://0001-drm-radeon-add-vm_set_page-tracepoint.patch;striplevel=1 \
           file://0002-drm-radeon-cleanup-flushing-on-CIK-v3.patch;striplevel=1 \
           file://0003-drm-radeon-cleanup-DMA-HDP-flush-on-CIK-v2.patch;striplevel=1 \
           file://0004-drm-radeon-allow-semaphore-emission-to-fail.patch;striplevel=1 \
           file://0005-drm-radeon-improve-ring-debugfs-a-bit.patch;striplevel=1 \
           file://0006-drm-radeon-report-the-real-offset-in-radeon_sa_bo_du.patch;striplevel=1 \
           file://0007-drm-radeon-update-fence-values-in-before-reporting-t.patch;striplevel=1 \
           file://0008-drm-radeon-cleanup-radeon_ttm-debugfs-handling.patch;striplevel=1 \
           file://0009-drm-radeon-add-VRAM-debugfs-access-v3.patch;striplevel=1 \
           file://0010-drm-radeon-add-GART-debugfs-access-v3.patch;striplevel=1 \
           file://0011-drm-radeon-fix-VMID-use-tracking.patch;striplevel=1 \
           file://0012-drm-radeon-add-missing-trace-point.patch;striplevel=1 \
           file://0013-drm-radeon-add-semaphore-trace-point.patch;striplevel=1 \
           file://0014-drm-radeon-add-VMID-allocation-trace-point.patch;striplevel=1 \
           file://0015-drm-radeon-add-uvd-debugfs-support.patch;striplevel=1 \
           file://0016-drm-radeon-add-radeon_vm_bo_update-trace-point.patch;striplevel=1 \
           file://0017-drm-radeon-drop-CP-page-table-updates-cleanup-v2.patch;striplevel=1 \
           file://0018-drm-radeon-add-large-PTE-support-for-NI-SI-and-CIK-v.patch;striplevel=1 \
           file://0019-drm-radeon-add-proper-support-for-RADEON_VM_BLOCK_SI.patch;striplevel=1 \
           file://0020-drm-radeon-WIP-add-copy-trace-point.patch;striplevel=1 \
           file://0021-drm-radeon-cik-Return-backend-map-information-to-use.patch;striplevel=1 \
           file://0022-drm-radeon-cik-Add-macrotile-mode-array-query.patch;striplevel=1 \
           file://0023-drm-radeon-set-correct-number-of-banks-for-CIK-chips.patch;striplevel=1 \
           file://0024-drm-radeon-don-t-power-gate-paused-UVD-streams.patch;striplevel=1 \
           file://0025-drm-radeon-dpm-retain-user-selected-performance-leve.patch;striplevel=1 \
           file://0026-drm-radeon-remove-generic-rptr-wptr-functions-v2.patch;striplevel=1 \
           file://0027-drm-radeon-initial-VCE-support-v4.patch;striplevel=1 \
           file://0028-drm-radeon-add-VCE-ring-query.patch;striplevel=1 \
           file://0029-drm-radeon-add-VCE-version-parsing-and-checking.patch;striplevel=1 \
           file://0030-drm-radeon-add-callback-for-setting-vce-clocks.patch;striplevel=1 \
           file://0031-drm-radeon-dpm-move-platform-caps-fetching-to-a-sepa.patch;striplevel=1 \
           file://0032-drm-radeon-dpm-fill-in-some-initial-vce-infrastructu.patch;striplevel=1 \
           file://0033-drm-radeon-dpm-fetch-vce-states-from-the-vbios.patch;striplevel=1 \
           file://0034-drm-radeon-fill-in-set_vce_clocks-for-CIK-asics.patch;striplevel=1 \
           file://0035-drm-radeon-add-vce-dpm-support-for-CI.patch;striplevel=1 \
           file://0036-drm-radeon-enable-vce-dpm-on-CI.patch;striplevel=1 \
           file://0037-drm-radeon-add-vce-dpm-support-for-KV-KB.patch;striplevel=1 \
           file://0038-drm-radeon-dpm-enable-dynamic-vce-state-switching-v2.patch;striplevel=1 \
           file://0039-drm-radeon-dpm-properly-enable-disable-vce-when-vce-.patch;striplevel=1 \
           file://0040-drm-radeon-add-vce-debugfs-support.patch;striplevel=1 \
           file://0041-drm-radeon-add-support-for-vce-2.0-clock-gating.patch;striplevel=1 \
           file://0042-drm-radeon-cik-enable-disable-vce-cg-when-encoding.patch;striplevel=1 \
           file://0043-drm-radeon-fix-CP-semaphores-on-CIK.patch;striplevel=1 \
           file://0044-drm-radeon-disable-dynamic-powering-vce.patch;striplevel=1 \
           file://0045-drm-radeon-add-Mullins-chip-family.patch;striplevel=1 \
           file://0046-drm-radeon-update-cik-init-for-Mullins.patch;striplevel=1 \
           file://0047-drm-radeon-add-Mullins-UVD-support.patch;striplevel=1 \
           file://0048-drm-radeon-add-Mullins-dpm-support.patch;striplevel=1 \
           file://0049-drm-radeon-modesetting-updates-for-Mullins.patch;striplevel=1 \
           file://0050-drm-radeon-add-pci-ids-for-Mullins.patch;striplevel=1 \
           file://0051-drm-radeon-add-Mulins-VCE-support.patch;striplevel=1 \
           file://0052-i2c-piix4-Use-different-message-for-AMD-Auxiliary-SM.patch;striplevel=1 \
           file://0053-ACPI-Set-acpi_enforce_resources-to-ENFORCE_RESOURCES.patch;striplevel=1 \
           file://0059-yocto-amd-staging-add-support-to-enable-and-disable-.patch;striplevel=1 \
           file://0060-yocto-amd-i2c-dev-add-calls-to-enable-and-disable-IM.patch;striplevel=1 \
 	   file://logo.cfg \
           file://console.cfg \
           file://logitech.cfg \
           file://efi-partition.cfg \
           file://sound.cfg \
           ${@base_contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
           file://disable-debug-preempt.cfg \
"

S = "${WORKDIR}/linux-${PV}"

SRC_URI[kernel.md5sum] = "0cadb5280ca8948fedd44734d3d6275f"
SRC_URI[kernel.sha256sum] = "f067eb4447c36358c7b2ee392e0a2470a232818998287acd98ec6295f1b1ed0c"
