FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_amd = " \
           file://logo.cfg \
           file://console.cfg \
           file://logitech.cfg \
           file://efi-partition.cfg \
           file://sound.cfg \
           ${@base_contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
"
kernel_do_install_append() {
	ln -s ${KERNEL_IMAGETYPE}-${KERNEL_VERSION} ${D}/${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}
}
