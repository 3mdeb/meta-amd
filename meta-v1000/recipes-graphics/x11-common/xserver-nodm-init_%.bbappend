# Force X to be run on vt7
do_install_append_v1000() {
    if [ -f ${D}${sysconfdir}/default/xserver-nodm ]; then
        echo "INPUT_EXTRA_ARGS=vt7" >> ${D}${sysconfdir}/default/xserver-nodm
    fi
}
