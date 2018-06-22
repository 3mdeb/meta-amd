gtk_immodule_cache_postinst_amd() {
}
pkg_postinst_matchbox-keyboard-im_amd () {
}
pkg_postinst_ontarget_matchbox-keyboard-im_amd () {
    if [ ! -z `which gtk-query-immodules-2.0` ]; then
        gtk-query-immodules-2.0 > ${libdir}/gtk-2.0/2.10.0/immodules.cache
    fi
    if [ ! -z `which gtk-query-immodules-3.0` ]; then
        gtk-query-immodules-3.0 > ${libdir}/gtk-3.0/3.0.0/immodules.cache
    fi
}
