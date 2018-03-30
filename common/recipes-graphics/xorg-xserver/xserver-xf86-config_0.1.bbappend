FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Additional options that you want
# to set in final xorg configuration.
# Convention is option,value. If there's
# no value requred simply skip just
# like DRI3.
AMDGPU_OPTS = "DRI3, TearFree,on"
RADEON_OPTS = ""

do_install_append_amdgpu () {
    if [ "${RT_KERNEL_AMD}" = "yes" ]; then
        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
    else
        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "amdgpu"/' ${D}/${sysconfdir}/X11/xorg.conf
        sed -i -e 's/^\tDriver      "fbdev"/\tDriver      "amdgpu"/' ${D}/${sysconfdir}/X11/xorg.conf
        set_xorg_opts "${AMDGPU_OPTS}"
    fi
}

do_install_append_radeon () {
    if [ "${RT_KERNEL_AMD}" = "yes" ]; then
        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
    else
        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "radeon"/' ${D}/${sysconfdir}/X11/xorg.conf
        sed -i -e 's/^\tDriver      "fbdev"/\tDriver      "radeon"/' ${D}/${sysconfdir}/X11/xorg.conf
        set_xorg_opts "${RADEON_OPTS}"
    fi
}

set_xorg_opts() {
    for opt_val in ${1}; do
        opt=$(echo ${opt_val} | cut -d',' -f1)
        val=$(echo ${opt_val} | cut -d',' -f2)
        if [ "${val}" = "" ]; then
            sed -i -e "/^\tIdentifier  \"Card0\"/i \\\tOption      \"${opt}\"" ${D}/${sysconfdir}/X11/xorg.conf
        else
            sed -i -e "/^\tIdentifier  \"Card0\"/i \\\tOption      \"${opt}\"     \"${val}\"" ${D}/${sysconfdir}/X11/xorg.conf
        fi
    done
}
