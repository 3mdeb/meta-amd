FIRMWARE_DIR="/lib/firmware/"
do_install_amd() {
	install -d  ${D}${FIRMWARE_DIR}
	for dir in */; do
	    cp -rf $dir/* ${D}${FIRMWARE_DIR}
	done
	rm -f ${D}${FIRMWARE_DIR}/LICENSE* ${D}${FIRMWARE_DIR}/COPYRIGHT \
	      ${D}${FIRMWARE_DIR}/defines

	# Avoid Makefile to be deplyed
	rm -f ${D}${FIRMWARE_DIR}/Makefile

	# Remove carl9170 firmware sources
	rm -rf ${D}${FIRMWARE_DIR}/carl9170fw

	# Libertas sd8686
	ln -sf libertas/sd8686_v9.bin ${D}${FIRMWARE_DIR}/sd8686.bin
	ln -sf libertas/sd8686_v9_helper.bin ${D}${FIRMWARE_DIR}/sd8686_helper.bin

	# fixup wl12xx location, after 2.6.37 the kernel searches a different location for it
	( cd ${D}${FIRMWARE_DIR} ; ln -sf ti-connectivity/* . )

	chmod -R g-ws ${D}
}

FILES_${PN} += "${FIRMWARE_DIR}/*"
