PACKAGECONFIG[vdpau] = "--enable-vdpau,--disable-vdpau,libvdpau"
PACKAGECONFIG_append_amdgpu = " vdpau"
PACKAGECONFIG_append_radeon = " vdpau"
