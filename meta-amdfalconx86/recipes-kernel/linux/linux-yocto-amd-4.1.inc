FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

SRCREV_meta_amdfalconx86 = "b9023d4c8fbbb854c26f158a079a5f54dd61964d"

LINUX_VERSION_amdfalconx86 = "4.1.18"
KMACHINE_amdfalconx86 = "amdfalconx86"

KCONF_BSP_AUDIT_LEVEL = "0"

COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"
KERNEL_FEATURES_append_amdfalconx86 += " cfg/smp.scc cfg/sound.scc"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-extra-config.cfg \
				${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
				${@bb.utils.contains("DISTRO", "mel", "", "file://disable-kgdb.cfg", d)} \
				file://usb-serial.cfg \
"

# Drop the keyring fix coming in from mel-updates
# the 4.1.18 kernel has it already.
SRC_URI_remove_amdfalconx86 = "file://kernel-keyring-CVE-2016-0728.patch"

# strip trailing ';' to workaround bb.fetch.URI bug
python () {
	src_uri = d.getVar('SRC_URI', True).split()
	d.setVar('SRC_URI', ' '.join(s.rstrip(";") for s in src_uri))
}

do_validate_branches_append() {
    # Drop a config generating spurious warnings
    sed -i '/CONFIG_DRM_I915_PRELIMINARY_HW_SUPPORT/d' ${WORKDIR}/${KMETA}/features/i915/i915.cfg
}
