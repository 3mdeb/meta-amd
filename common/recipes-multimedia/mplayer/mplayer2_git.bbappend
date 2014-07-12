do_install_append_amd() {
    [ -e ${D}/usr/lib ] && rmdir ${D}/usr/lib
}
