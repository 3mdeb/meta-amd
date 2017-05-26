do_install_append_v1000 () {
     sed -i -e 's/^\tBusID       "PCI:0:1:0"/\tBusID       "PCI:1:0:0"/' ${D}/${sysconfdir}/X11/xorg.conf
}
