FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV_v1000 = "d07a49fb1840bb441e600ce942cb0088e7ea15c7"
LIC_FILES_CHKSUM_v1000 = "file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4"
PV_v1000 = "18.1.0+git${SRCPV}"

MESA_LLVM_RELEASE_v1000 = "6.0"

export LLVM_CONFIG = "${STAGING_BINDIR_NATIVE}/llvm-config${MESA_LLVM_RELEASE_v1000}"
export YOCTO_ALTERNATE_EXE_PATH = "${STAGING_LIBDIR}/llvm${MESA_LLVM_RELEASE}/llvm-config"

PACKAGECONFIG_append_v1000 = " dri3"

PACKAGECONFIG[egl] = "--enable-egl --with-platforms=${EGL_PLATFORMS}, --disable-egl"
PACKAGECONFIG[gallium-llvm] = "--enable-llvm --enable-llvm-shared-libs, --disable-llvm, llvm${MESA_LLVM_RELEASE} llvm-native \
                              ${@'elfutils' if ${GALLIUMDRIVERS_LLVM33_ENABLED} else ''}"

EXTRA_OECONF_remove_v1000 = "--enable-omx --with-omx-libdir=${libdir}/bellagio --enable-nls"
EXTRA_OECONF_append_v1000 = "--enable-omx-bellagio \
                             --with-omx-bellagio-libdir=${libdir}/bellagio \
                             --with-llvm-prefix=${STAGING_LIBDIR}/llvm${MESA_LLVM_RELEASE}"

SRC_URI_v1000 = "\
			git://anongit.freedesktop.org/mesa/mesa;branch=master \
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
                        file://0001-configure.ac-adjust-usage-of-LLVM-flags.patch \
"

MESA_CRYPTO_v1000 = ""

