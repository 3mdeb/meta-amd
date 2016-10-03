FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

KBRANCH_amdx86 ?= "standard/base"
KMACHINE_amdx86 ?= "common-pc-64"
LINUX_VERSION_amdx86 ?= "4.4.20"

SRC_URI_append_amdx86 += " \
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

SRC_URI_append_radeon += " \
	file://radeon-microcode.cfg \
	file://radeon-console.cfg \
	file://radeon-gpu-config.cfg \
"

KERNEL_FEATURES_append_amdx86 = " cfg/smp.scc cfg/sound.scc"

# Drop the keyring fix coming in from mel-updates
# the 4.1.18 kernel has it already.
SRC_URI_remove = "file://kernel-keyring-CVE-2016-0728.patch"

# strip trailing ';' to workaround bb.fetch.URI bug
python () {
	src_uri = d.getVar('SRC_URI', True).split()
	d.setVar('SRC_URI', ' '.join(s.rstrip(";") for s in src_uri))
}

do_validate_branches_append() {
    # Drop a config generating spurious warnings
    sed -i '/CONFIG_DRM_I915_PRELIMINARY_HW_SUPPORT/d' ${WORKDIR}/${KMETA}/features/i915/i915.cfg
}

#
# Work around race in linux-yocto recipe for archive files.
# This is fixed properly in the master branch with:
#     http://patchwork.openembedded.org/patch/107179/
#
python do_ar_patched_prepend() {
    bb.utils.mkdirhier("${STAGING_KERNEL_BUILDDIR}")
    bb.utils.mkdirhier("${STAGING_KERNEL_DIR}")
}
