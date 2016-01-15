FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.10"

SRCREV_meta_amdfalconx86 ?= "2c21e694e2bf211c858a32fab1c03a398b599439"

LINUX_VERSION_amdfalconx86 = "3.14.24"
COMPATIBLE_MACHINE_amdfalconx86 = "amdfalconx86"
KERNEL_FEATURES_append_amdfalconx86 += " cfg/smp.scc cfg/sound.scc"

# do no print configuration warnings on build console
KCONF_AUDIT_LEVEL = "0"
KCONF_BSP_AUDIT_LEVEL = "0"

SRC_URI_append_amdfalconx86 += "file://amdfalconx86-user-config.cfg \
				file://amdfalconx86-user-features.scc \
				file://amdfalconx86-user-patches.scc \
				${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
				${@bb.utils.contains("DISTRO", "mel", "", "file://disable-kgdb.cfg", d)} \
				file://usb-serial.cfg \
"

do_validate_branches_append() {
    # Fixed in 3.14.29 tag of yocto-kernel-cache branch yocto-3.14
    rm -r ${WORKDIR}/${KMETA}/meta

    # Fixed in >3.14.29 tag of yocto-kernel-cache branch yocto-3.14
    sed -i '/crui.scc/d' ${WORKDIR}/${KMETA}/ktypes/standard/standard.scc

    # Fixed in >3.14.29 tag of yocto-kernel-cache branch yocto-3.14
    sed -i '/crui.scc/d' ${WORKDIR}/${KMETA}/ktypes/preempt-rt/preempt-rt.scc
}

# strip trailing ';' to workaround bb.fetch.URI bug
python () {
	src_uri = d.getVar('SRC_URI', True).split()
	d.setVar('SRC_URI', ' '.join(s.rstrip(";") for s in src_uri))
}
