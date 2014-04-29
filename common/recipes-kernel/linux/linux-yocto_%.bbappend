kernel_do_install_append() {
	ln -s ${KERNEL_IMAGETYPE}-${KERNEL_VERSION} ${D}/${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}
}
