do_install_prepend_amdfalconx86 () {
        sed -i -e 's/^\tDriver      "radeon"/	Driver      "amdgpu"/' ${WORKDIR}/xorg.conf
}
