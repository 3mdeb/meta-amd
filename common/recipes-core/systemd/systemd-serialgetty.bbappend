# We would like to force baud rate on all
# SERIAL_CONSOLES strip --keep-baud which
# wouldn't allow this.
do_install_prepend_amd() {
	if [ ! -z "${SERIAL_CONSOLES}" ] ; then
		sed -i -e s/\-\-keep\-baud//g ${WORKDIR}/serial-getty@.service
    fi
}
