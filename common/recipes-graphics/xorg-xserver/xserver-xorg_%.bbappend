PACKAGECONFIG[glamor] = "--enable-glamor,--disable-glamor,libepoxy"
PACKAGECONFIG_append_amdgpu = " glamor xshmfence dri3"
PACKAGECONFIG_append_radeon = " glamor xshmfence"
