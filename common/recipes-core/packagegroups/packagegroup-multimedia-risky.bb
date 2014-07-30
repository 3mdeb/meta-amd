DESCRIPTION = "AMD risky multimedia packages"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
PR = "r0"

inherit packagegroup

RDEPENDS_${PN} += "\
    libfaad \
    libid3tag \
    libmad \
    gstreamer1.0-plugins-bad-meta \
    gstreamer1.0-plugins-ugly-meta \
    gstreamer1.0-libav \
"

#
# To enable this package group, add the following to your local.conf.
#
# Note that this will add binaries to your output that have IP issues or other
# restrictions.  This is explicitly _not_ enabled in the default configuration
# due to this.
#
#IMAGE_INSTALL_append += " packagegroup-multimedia-risky"
#LICENSE_FLAGS_WHITELIST += " commercial_libmad commercial_gstreamer1.0-plugins-ugly commercial_lame commercial_mpeg2dec"
