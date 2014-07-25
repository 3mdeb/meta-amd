FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_amd = " \
           file://logo.cfg \
           file://console.cfg \
           file://logitech.cfg \
           file://efi-partition.cfg \
           ${@base_contains("DISTRO_FEATURES", "bluetooth", "file://bluetooth.cfg", "", d)} \
           file://0001-xhci-Enable-XHCI_TRUST_TX_LENGTH-quirk-for-AMD-devic.patch \
"
kernel_do_install_append() {
	ln -s ${KERNEL_IMAGETYPE}-${KERNEL_VERSION} ${D}/${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}
}
