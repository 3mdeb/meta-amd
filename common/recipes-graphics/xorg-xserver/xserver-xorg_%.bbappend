PACKAGECONFIG[glamor] = "--enable-glamor,--disable-glamor,libepoxy"
PACKAGECONFIG_append_amdgpu = " glamor xshmfence"
PACKAGECONFIG_append_radeon = " glamor xshmfence"
