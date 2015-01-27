DEPENDS_append_amd = " python3-native"

do_compile_prepend_amd() {
    # Make sure we can find python3
    export PATH="${PATH}:${STAGING_BINDIR_NATIVE}/python3-native"
}

do_install_append_amd() {
    [ -e ${D}/usr/lib ] && rmdir ${D}/usr/lib
}

PNBLACKLIST[mplayer2] = ""

#
# Make sure we can find the configure script
#
B = "${S}"
