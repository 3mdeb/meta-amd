FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_baldeagle = " \
           ${@base_contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
"
SRC_URI_append_steppeeagle += " \
           ${@base_contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
"
kernel_do_install_append() {
	ln -s ${KERNEL_IMAGETYPE}-${KERNEL_VERSION} ${D}/${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}
}
