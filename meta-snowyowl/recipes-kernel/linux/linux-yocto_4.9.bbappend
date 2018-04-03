require linux-yocto-snowyowl_4.9.inc

SRC_URI_append_snowyowl += "file://snowyowl-standard-only.cfg"
SRC_URI_append_snowyowl += "file://disable-graphics.cfg"

# openssl-dev is required for features such as module signing
DEPENDS_append = " openssl-native"

# backported from OE-core so things such as openssl-native listed
# above can be picked up from the native sysroot
EXTRA_OEMAKE = " HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}" HOSTCPP="${BUILD_CPP}""

do_validate_branches_append() {
    # Droping configs related to sound generating spurious warnings
    sed -i '/kconf hardware snd_hda_intel.cfg/d' ${WORKDIR}/${KMETA}/features/sound/snd_hda_intel.scc

    # Droping configs related to graphics generating spurious warnings
    sed -i '/CONFIG_FB/d' ${WORKDIR}/${KMETA}/bsp/common-pc/common-pc-gfx.cfg
    sed -i '/CONFIG_DRM/d' ${WORKDIR}/${KMETA}/bsp/common-pc/common-pc-gfx.cfg
    sed -i '/CONFIG_FRAMEBUFFER_CONSOLE/d' ${WORKDIR}/${KMETA}/bsp/common-pc/common-pc-gfx.cfg
    sed -i '/kconf hardware i915.cfg/d' ${WORKDIR}/${KMETA}/features/i915/i915.scc
    sed -i '/CONFIG_FB/d' ${WORKDIR}/${KMETA}/cfg/efi-ext.cfg
    sed -i '/CONFIG_FRAMEBUFFER_CONSOLE/d' ${WORKDIR}/${KMETA}/cfg/efi-ext.cfg
}
