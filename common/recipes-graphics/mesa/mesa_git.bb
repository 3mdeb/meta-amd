require recipes-graphics/mesa/${BPN}.inc

S = "${WORKDIR}/git"

DEPENDS_append = " python-mako-native"
inherit pythonnative

SRCREV_amd = "d07a49fb1840bb441e600ce942cb0088e7ea15c7"
LIC_FILES_CHKSUM_amd = "file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4"
PV_amd = "18.1.0+git${SRCPV}"

DEPENDS_append_amd = " libvdpau libomxil"

PACKAGECONFIG[va] = "--enable-va,--disable-va,libva"
PACKAGECONFIG_append_amd = " xvmc gallium r600 gallium-llvm xa"
PACKAGECONFIG_append_radeon = " va"
PACKAGECONFIG_append_amdgpu = " va"

PACKAGECONFIG_remove_amd = "vulkan"
PACKAGECONFIG_remove_amdfalconx86 = "xvmc"

LIBVA_PLATFORMS  = "libva"
LIBVA_PLATFORMS .= "${@bb.utils.contains('DISTRO_FEATURES', 'x11', ' libva-x11', '', d)}"
LIBVA_PLATFORMS .= "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', ' libva-wayland', '', d)}"
LIBVA_PLATFORMS .= "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', ' libva-gl', '', d)}"
RDEPENDS_mesa-megadriver += "${@bb.utils.contains('PACKAGECONFIG', 'va', '${LIBVA_PLATFORMS}', '', d)}"

MESA_LLVM_RELEASE_amd = "6.0"

SRC_URI_amd = "git://anongit.freedesktop.org/mesa/mesa;branch=master \
               file://0001-st-omx-enc-fix-blit-setup-for-YUV-LoadImage.patch \
               file://0002-mesa-st-glsl_to_tgsi-Split-arrays-who-s-elements-are.patch \
               file://0003-mesa-st-glsl_to_tgsi-rename-lifetime-to-register_liv.patch \
               file://0004-mesa-st-Add-helper-classes-for-array-merging-and-int.patch \
               file://0005-mesa-st-glsl_to_tgsi-Add-class-to-hold-array-informa.patch \
               file://0006-mesa-st-glsl_to_tgsi-Add-array-merge-logic.patch \
               file://0007-mesa-st-tests-Add-unit-tests-for-array-merge-helper-.patch \
               file://0008-mesa-st-glsl_to_tgsi-refactor-access_record-and-its-.patch \
               file://0009-mesa-st-glsl_to_tgsi-move-evaluation-of-read-mask-up.patch \
               file://0010-mesa-st-glsl_to_tgsi-add-class-for-array-access-trac.patch \
               file://0011-mesa-st-glsl_to_tgsi-add-array-life-range-evaluation.patch \
               file://0012-mesa-st-glsl_to_tgsi-Expose-array-live-range-trackin.patch \
               file://0013-mesa-st-glsl_to_tgsi-Properly-resolve-life-times-for.patch \
               file://0001-configure.ac-obey-llvm_prefix-if-available.patch \
               file://0001-configure.ac-adjust-usage-of-LLVM-flags.patch"

EXTRA_OECONF_append_amd = " \
		 --enable-vdpau \
		 --enable-osmesa \
		 --enable-glx \
		 --enable-omx-bellagio \
		 --with-omx-bellagio-libdir=${libdir}/bellagio \
		 --enable-texture-float"

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

#because we cannot rely on the fact that all apps will use pkgconfig,
#make eglplatform.h independent of MESA_EGL_NO_X11_HEADER
do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'egl', 'true', 'false', d)}; then
        sed -i -e 's/^#if defined(MESA_EGL_NO_X11_HEADERS)$/#if defined(MESA_EGL_NO_X11_HEADERS) || ${@bb.utils.contains('PACKAGECONFIG', 'x11', '0', '1', d)}/' ${D}${includedir}/EGL/eglplatform.h
    fi
}

