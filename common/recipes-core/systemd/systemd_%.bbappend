pkg_postinst_udev-hwdb_amd () {
}
pkg_postinst_ontarget_udev-hwdb_amd () {
    udevadm hwdb --update
}
