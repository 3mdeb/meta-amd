FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR := "${INC_PR}.1"

SRCREV_meta_amdfalconx86 = "46bb64d605fd336d99fa05bab566b9553b40b4b4"

LINUX_VERSION_amdfalconx86 = "4.1.15"
KMACHINE_amdfalconx86 = "amdfalconx86"

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

# strip trailing ';' to workaround bb.fetch.URI bug
python () {
	src_uri = d.getVar('SRC_URI', True).split()
	d.setVar('SRC_URI', ' '.join(s.rstrip(";") for s in src_uri))
}
