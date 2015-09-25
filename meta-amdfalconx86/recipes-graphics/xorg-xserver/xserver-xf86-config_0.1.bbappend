do_install_append_amdfalconx86 () {
	if [ "${RT_KERNEL_AMDFALCONX86}" = "yes" ]; then
	        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
	        sed -i -e 's/^\tDriver      "amdgpu"/\tDriver      "fbdev"/' ${D}/${sysconfdir}/X11/xorg.conf
	else
	        sed -i -e 's/^\tDriver      "radeon"/\tDriver      "amdgpu"/' ${D}/${sysconfdir}/X11/xorg.conf
	        sed -i -e 's/^\tDriver      "fbdev"/\tDriver      "amdgpu"/' ${D}/${sysconfdir}/X11/xorg.conf
	fi
	sed -i '/.\"SWcursor\"./c\\tOption      "SWcursor"           \t"True"' ${D}/${sysconfdir}/X11/xorg.conf
}
