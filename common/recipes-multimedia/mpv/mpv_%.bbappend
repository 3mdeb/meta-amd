PACKAGECONFIG[drm] = "--enable-drm, --disable-drm, libdrm"
PACKAGECONFIG[gbm] = "--enable-gbm, --disable-gbm, virtual/libgl"
PACKAGECONFIG[vdpau] = "--enable-vdpau, --disable-vdpau, libvdpau"
PACKAGECONFIG[va] = "--enable-vaapi, --disable-vaapi, libva"

PACKAGECONFIG_append_amdx86 = " drm gbm vdpau va"
PACKAGECONFIG_remove_amdx86 = "lua"

EXTRA_OECONF_remove = "--disable-gl"
EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', '--enable-gl', '--disable-gl', d)}"
