PACKAGECONFIG_append_amdx86 = " drm gbm vdpau vaapi"
PACKAGECONFIG_remove_amdx86 = "lua"

EXTRA_OECONF_remove = "--disable-gl"
EXTRA_OECONF_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', '--enable-gl', '--disable-gl', d)}"
