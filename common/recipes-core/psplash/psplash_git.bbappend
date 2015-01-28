do_install[postfuncs] += "systemd_dep"

systemd_dep () {
    if [ -f ${D}${systemd_unitdir}/system/psplash-quit.service ]; then
        sed -i '/After=psplash-start.service/a Before=display-manager.service' ${D}${systemd_unitdir}/system/psplash-quit.service
    fi
}
