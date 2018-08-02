DESCRIPTION = "The Low Level Virtual Machine"
HOMEPAGE = "http://llvm.org"

# 3-clause BSD-like
# University of Illinois/NCSA Open Source License
LICENSE = "NCSA"
LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=e825e017edc35cfd58e26116e5251771"

DEPENDS = "libffi libxml2 zlib ninja-native"
DEPENDS_append_class-target = " llvm-native"
RDEPENDS_${PN}_append_class-target = " ncurses-terminfo"

inherit perlnative pythonnative cmake

PROVIDES += "llvm"

LLVM_RELEASE = "${PV}"
LLVM_DIR = "llvm${LLVM_RELEASE}"

SRCREV = "089d4c0c490687db6c75f1d074e99c4d42936a50"
PV = "6.0"
PATCH_VERSION = "0"
SRC_URI = "git://github.com/llvm-mirror/llvm.git;branch=release_60;protocol=http \
        file://0001-llvm-TargetLibraryInfo-Undefine-libc-functions-if-th.patch \
        file://0002-llvm-allow-env-override-of-exe-path.patch \
        file://0001-Disable-generating-a-native-llvm-config.patch \
        file://0001-llvm-config-allow-overriding-libdir-through-cmdline.patch \
"
S = "${WORKDIR}/git"

LLVM_INSTALL_DIR = "${WORKDIR}/llvm-install"

EXTRA_OECMAKE += "-DLLVM_ENABLE_ASSERTIONS=OFF \
                  -DLLVM_ENABLE_EXPENSIVE_CHECKS=OFF \
                  -DLLVM_BINDINGS_LIST="" \
                  -DLLVM_LINK_LLVM_DYLIB=ON \
                  -DLLVM_ENABLE_FFI=ON \
                  -DLLVM_OPTIMIZED_TABLEGEN=ON \
                  -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" \
                  -G Ninja"

EXTRA_OECMAKE_append_class-target = "\
    -DCMAKE_CROSSCOMPILING:BOOL=ON \
    -DLLVM_TABLEGEN=${STAGING_BINDIR_NATIVE}/llvm-tblgen${PV} \
"

EXTRA_OECMAKE_append_class-nativesdk = "\
    -DCMAKE_CROSSCOMPILING:BOOL=ON \
    -DLLVM_TABLEGEN=${STAGING_BINDIR_NATIVE}/llvm-tblgen${PV} \
"

do_configure_prepend() {
    # Fix paths in llvm-config
    sed -i "s|sys::path::parent_path(CurrentPath))\.str()|sys::path::parent_path(sys::path::parent_path(CurrentPath))).str()|g" ${S}/tools/llvm-config/llvm-config.cpp
    sed -ri "s#/(bin|include|lib)(/?\")#/\1/${LLVM_DIR}\2#g" ${S}/tools/llvm-config/llvm-config.cpp
    sed -ri "s#lib/${LLVM_DIR}#${baselib}/${LLVM_DIR}#g" ${S}/tools/llvm-config/llvm-config.cpp
}

do_compile() {
    NINJA_STATUS="[%p] " ninja -v
}

do_compile_class-native() {
    NINJA_STATUS="[%p] " ninja -v ${PARALLEL_MAKE} llvm-config llvm-tblgen
}

do_install() {
    DESTDIR=${LLVM_INSTALL_DIR} ninja -v install

    install -D -m 0755 ${B}/bin/llvm-config ${D}${libdir}/${LLVM_DIR}/llvm-config

    install -d ${D}${bindir}/${LLVM_DIR}
    cp -r ${LLVM_INSTALL_DIR}${bindir}/* ${D}${bindir}/${LLVM_DIR}/

    install -d ${D}${includedir}/${LLVM_DIR}
    cp -r ${LLVM_INSTALL_DIR}${includedir}/* ${D}${includedir}/${LLVM_DIR}/

    install -d ${D}${libdir}/${LLVM_DIR}

    # The LLVM sources have "/lib" embedded and so we cannot completely rely on the ${libdir} variable
    if [ -d ${LLVM_INSTALL_DIR}${libdir}/ ]; then
        cp -r ${LLVM_INSTALL_DIR}${libdir}/* ${D}${libdir}/${LLVM_DIR}/
    elif [ -d ${LLVM_INSTALL_DIR}${prefix}/lib ]; then
        cp -r ${LLVM_INSTALL_DIR}${prefix}/lib/* ${D}${libdir}/${LLVM_DIR}/
    elif [ -d ${LLVM_INSTALL_DIR}${prefix}/lib64 ]; then
        cp -r ${LLVM_INSTALL_DIR}${prefix}/lib64/* ${D}${libdir}/${LLVM_DIR}/
    fi

    # Remove unnecessary cmake files
    rm -rf ${D}${libdir}/${LLVM_DIR}/cmake

    ln -s ${LLVM_DIR}/libLLVM-${PV}${SOLIBSDEV} ${D}${libdir}/libLLVM-${PV}${SOLIBSDEV}

    # We'll have to delete libLLVM.so and libLTO.so due to multiple reasons...
    rm -rf ${D}${libdir}/${LLVM_DIR}/libLLVM.so
    rm -rf ${D}${libdir}/${LLVM_DIR}/libLTO.so
}

do_install_class-native() {
    install -D -m 0755 ${B}/bin/llvm-tblgen ${D}${bindir}/llvm-tblgen${PV}
    install -D -m 0755 ${B}/bin/llvm-config ${D}${bindir}/llvm-config${PV}
    install -D -m 0755 ${B}/lib/libLLVM-${PV}.so ${D}${libdir}/libLLVM-${PV}.so
}

PACKAGES += "${PN}-bugpointpasses ${PN}-llvmhello"
ALLOW_EMPTY_${PN} = "1"
ALLOW_EMPTY_${PN}-staticdev = "1"
FILES_${PN} = ""
FILES_${PN}-staticdev = ""
FILES_${PN}-dbg = " \
    ${bindir}/${LLVM_DIR}/.debug \
    ${libdir}/${LLVM_DIR}/.debug/BugpointPasses.so \
    ${libdir}/${LLVM_DIR}/.debug/LLVMHello.so \
    ${libdir}/${LLVM_DIR}/.debug/libLTO.so* \
    ${libdir}/${LLVM_DIR}/.debug/llvm-config \
    /usr/src/debug \
"

FILES_${PN}-dev = " \
    ${bindir}/${LLVM_DIR} \
    ${includedir}/${LLVM_DIR} \
    ${libdir}/${LLVM_DIR}/llvm-config \
"
RRECOMMENDS_${PN}-dev += "${PN}-bugpointpasses ${PN}-llvmhello"

FILES_${PN}-bugpointpasses = "\
    ${libdir}/${LLVM_DIR}/BugpointPasses.so \
"

FILES_${PN}-llvmhello = "\
    ${libdir}/${LLVM_DIR}/LLVMHello.so \
"

FILES_${PN} += "\
    ${libdir}/${LLVM_DIR}/libLTO.so.* \
"

PACKAGES_DYNAMIC = "^libllvm${LLVM_RELEASE}-.*$"
NOAUTOPACKAGEDEBUG = "1"

INSANE_SKIP_${MLPREFIX}libllvm${LLVM_RELEASE}-llvm-${LLVM_RELEASE}.${PATCH_VERSION} += "dev-so"
INSANE_SKIP_${MLPREFIX}libllvm${LLVM_RELEASE}-llvm-${LLVM_RELEASE} += "dev-so"
INSANE_SKIP_${MLPREFIX}libllvm${LLVM_RELEASE}-llvm += "dev-so"

python llvm_populate_packages() {
    libdir = bb.data.expand('${libdir}', d)
    libllvm_libdir = bb.data.expand('${libdir}/${LLVM_DIR}', d)
    split_dbg_packages = do_split_packages(d, libllvm_libdir+'/.debug', '^lib(.*)\.so$', 'libllvm${LLVM_RELEASE}-%s-dbg', 'Split debug package for %s', allow_dirs=True)
    split_packages = do_split_packages(d, libdir, '^lib(.*)\.so$', 'libllvm${LLVM_RELEASE}-%s', 'Split package for %s', allow_dirs=True, allow_links=True, recursive=True)
    split_staticdev_packages = do_split_packages(d, libllvm_libdir, '^lib(.*)\.a$', 'libllvm${LLVM_RELEASE}-%s-staticdev', 'Split staticdev package for %s', allow_dirs=True)
    if split_packages:
        pn = d.getVar('PN', True)
        d.appendVar('RDEPENDS_' + pn, ' '+' '.join(split_packages))
        d.appendVar('RDEPENDS_' + pn + '-dbg', ' '+' '.join(split_dbg_packages))
        d.appendVar('RDEPENDS_' + pn + '-staticdev', ' '+' '.join(split_staticdev_packages))
}

PACKAGESPLITFUNCS_prepend = "llvm_populate_packages "

BBCLASSEXTEND = "native nativesdk"
