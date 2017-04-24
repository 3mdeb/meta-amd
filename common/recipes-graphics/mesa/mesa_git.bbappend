FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCREV_amd = "09460b8cf7ddac4abb46eb6439314b29954c76a6"
LIC_FILES_CHKSUM_amd = "file://docs/license.html;md5=899fbe7e42d494c7c8c159c7001693d5"
PV_amd = "12.0.3+git${SRCPV}"
DEPENDS_append_amd = " libvdpau libomxil"

PACKAGECONFIG[va] = "--enable-va,--disable-va,libva"
PACKAGECONFIG_append_amd = " xvmc gallium r600 gallium-llvm xa"
PACKAGECONFIG_append_radeon = " va"
PACKAGECONFIG_append_amdgpu = " va"
PACKAGECONFIG_remove_amd = "dri3"
PACKAGECONFIG_remove_amdfalconx86 = "xvmc"

LIBVA_PLATFORMS  = "libva"
LIBVA_PLATFORMS .= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', ' libva-x11', '', d)}"
LIBVA_PLATFORMS .= "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', ' libva-wayland', '', d)}"
LIBVA_PLATFORMS .= "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', ' libva-gl', '', d)}"
RDEPENDS_mesa-megadriver += "${@bb.utils.contains('PACKAGECONFIG', 'va', '${LIBVA_PLATFORMS}', '', d)}"

MESA_LLVM_RELEASE_amd = "3.9.1"

SRC_URI_amd = "\
			git://anongit.freedesktop.org/git/mesa/mesa;branch=12.0 \
			file://0001-reverse-the-patch-radeonsi-rework-clear_buffer-flags.patch \
			file://0002-radeonsi-silence-runtime-warnings-with-LLVM-3.9.patch \
			file://0003-st-mesa-Revert-patches-solves-perf-issues-with-mesa-.patch \
			file://0004-st-mesa-fix-swizzle-issue-in-st_create_sampler_view_.patch \
			file://0005-Revert-winsys-amdgpu-add-back-multithreaded-command-.patch \
"

EXTRA_OECONF_append_amd = " \
		 --enable-vdpau \
		 --enable-osmesa \
		 --enable-glx \
		 --enable-omx \
		 --with-omx-libdir=${libdir}/bellagio \
		"

EXTRA_OECONF_append_amdfalconx86 = " \
		 --enable-texture-float \
		"

# Package all the libXvMC gallium extensions together
# they provide the shared lib libXvMCGallium and splitting
# them up creates trouble in rpm packaging
PACKAGES =+ "libxvmcgallium-${PN} libxvmcgallium-${PN}-dev"
FILES_libxvmcgallium-${PN} = "${libdir}/libXvMC*${SOLIBS}"
FILES_libxvmcgallium-${PN}-dev = "${libdir}/libXvMC*${SOLIBSDEV} \
                               ${libdir}/libXvMC*.la"

PACKAGES =+ "libvdpau-${PN} libvdpau-${PN}-dev"
FILES_libvdpau-${PN} = "${libdir}/vdpau/libvdpau*${SOLIBS}"
FILES_libvdpau-${PN}-dev = "${libdir}/vdpau/libvdpau*${SOLIBSDEV} \
                            ${libdir}/vdpau/libvdpau*.la"
FILES_${PN}-dbg += "${libdir}/vdpau/.debug"

#
# libomx files are non-versioned so we put *.so directly in the
# main package as opposed to the -dev package.
#
PACKAGES =+ "libomx-${PN} libomx-${PN}-dev"
FILES_libomx-${PN} = "${libdir}/bellagio/libomx_*.so"
FILES_libomx-${PN}-dev = "${libdir}/bellagio/libomx_*.la"
FILES_${PN}-dbg += "${libdir}/bellagio/.debug"

# Set DRIDRIVERS with anonymous python so we can effectively
# override the _append_x86-64 assignement from mesa.inc.
python () {
    d.setVar("DRIDRIVERS", "swrast,radeon")
    d.setVar("GALLIUMDRIVERS", "swrast,r300,r600,radeonsi")
}

# We're using components like vdpau which depend
# on nettle so lets just use it as the default for
# crypto as well.
MESA_CRYPTO ?= "nettle"
