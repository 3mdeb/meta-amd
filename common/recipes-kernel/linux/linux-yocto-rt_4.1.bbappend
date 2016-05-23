FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

KBRANCH_amdx86 ?= "standard/preempt-rt/base"
KMACHINE_amdx86 ?= "common-pc-64"
SRCREV_machine_amdx86 ?= "73c76150065091f6cc1751a3c8ec2d8a8cf8b6af"
SRCREV_meta_amdx86 ?= "b9023d4c8fbbb854c26f158a079a5f54dd61964d"
LINUX_VERSION_amdx86 ?= "4.1.18"

SRC_URI_append_amdx86 += " \
	file://linux-yocto-amd-patches.scc \
	file://logo.cfg \
	file://console.cfg \
	file://drm.cfg \
	file://sound.cfg \
	file://hid.cfg \
	file://enable-imc.cfg \
	file://efi-partition.cfg \
	file://usb-serial.cfg \
	file://wifi-drivers.cfg \
	file://disable-intel-graphics.cfg \
	${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'file://enable-bluetooth.cfg', 'file://disable-bluetooth.cfg', d)} \
	${@bb.utils.contains('DISTRO', 'mel', 'file://enable-kgdb.cfg', 'file://disable-kgdb.cfg', d)} \
"

KERNEL_FEATURES_append_amdx86 += " cfg/smp.scc cfg/sound.scc"

# strip trailing ';' to workaround bb.fetch.URI bug
python () {
       src_uri = d.getVar('SRC_URI', True).split()
       d.setVar('SRC_URI', ' '.join(s.rstrip(";") for s in src_uri))
}

do_validate_branches_append() {
    # Drop a config generating spurious warnings
    sed -i '/CONFIG_DRM_I915_PRELIMINARY_HW_SUPPORT/d' ${WORKDIR}/${KMETA}/features/i915/i915.cfg
}
