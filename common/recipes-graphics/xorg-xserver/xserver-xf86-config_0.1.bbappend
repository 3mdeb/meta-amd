FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_install_append_amdgpu () {
	if [ "${RT_KERNEL_AMD}" = "yes" ]; then
	        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
	        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
	else
	        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "amdgpu"/' ${D}/${sysconfdir}/X11/xorg.conf
	        sed -i -e 's/^\tDriver      "fbdev"/\tDriver      "amdgpu"/' ${D}/${sysconfdir}/X11/xorg.conf
		sed -i -e 's/^\tIdentifier  "Card0"/\tOption     "DRI3"\n\tIdentifier  "Card0"/' ${D}/${sysconfdir}/X11/xorg.conf
	fi
}

do_install_append_radeon () {
	if [ "${RT_KERNEL_AMD}" = "yes" ]; then
	        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
	        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
	else
	        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "radeon"/' ${D}/${sysconfdir}/X11/xorg.conf
	        sed -i -e 's/^\tDriver      "fbdev"/\tDriver      "radeon"/' ${D}/${sysconfdir}/X11/xorg.conf
	fi
}
