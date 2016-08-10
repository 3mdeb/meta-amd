do_install_append_amd() {
    # Do not install the boot time auto launcher
    rm -rf ${D}${sysconfdir}/xdg/autostart
}
