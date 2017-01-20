SUMMARY = "CodeXL enables developers to harness the benefits of CPUs, GPUs and APUs."

DESCRIPTION = "CodeXL is a comprehensive tool suite that enables developers \
to harness the benefits of CPUs, GPUs and APUs. It includes powerful GPU \
debugging, comprehensive GPU and CPU profiling, DirectX12® Frame \
Analysis, static OpenCL™, OpenGL®, Vulkan® and DirectX® kernel/shader \
analysis capabilities, and APU/CPU/GPU power profiling, enhancing \
accessibility for software developers to enter the era of heterogeneous \
computing. CodeXL is available both as a Visual Studio® extension and a \
standalone user interface application for Windows® and Linux®."

HOMEPAGE = "https://github.com/GPUOpen-Tools/CodeXL"

BUGTRACKER = "https://github.com/GPUOpen-Tools/CodeXL/issues"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=37475e90e7cba036e30d0c8b0af68173"

DEPENDS += "boost fltk gtk+ glew libtinyxml"
RDEPENDS_${PN} += "gdb connman-wait-online"

PV = "2.2+git${SRCPV}"

SRCREV = "7c0d7296a22afd34654c42f2d7a915cba0f4b38e"
SRC_URI = " \
     gitsm://github.com/GPUOpen-Tools/CodeXL.git;branch=2.2;protocol=https \
     file://0001-cross-compile-compatibility.patch \
     file://0002-set-the-scons-execution-environment.patch \
     file://0003-set-the-scons-construction-environment.patch \
     file://0004-set-the-CPPFLAGS-for-cross-compile.patch \
     file://0005-set-the-LIBPATH-for-cross-compile.patch \
     file://0006-modify-compiler_base_flags.patch \
     file://0007-donot-use-the-local-copy-of-libstdc.patch \
     file://0008-Examples-AMDTTeaPot-fix-a-null-pointer-exception.patch \
     file://0009-remove-remote-agent-dependency-on-UI-components.patch \
     file://0010-fix-CXL_env-update-code-position.patch \
     file://0011-tune-gpu-profiler-backend-metadata-for-cross-compila.patch \
     file://0012-pwrprof-driver-tune-metadata-for-crosscompile.patch \
     file://0013-do-not-use-local-libGLEW.patch \
     file://0014-do-not-use-local-tinyxml.patch \
     file://0015-add-build-control-flag-CXL_RA_only.patch \
     file://0016-add-build-control-flag-CXL_sysroot_dir.patch \
     file://0017-add-tinxml-to-list-of-LIBS-for-CapturePlayer.patch \
     file://0018-AMDTAPIClasses-fix-build-with-gcc6.patch \
     file://0019-Miniz-fix-build-with-gcc6.patch \
     file://0020-WebServer-fix-misleading-cleanup-under-RemoveHandler.patch \
     file://0021-AMDTPowerProfileApi-fix-build-issues.patch \
     file://0022-GpuProfiling-disable-ignored-attributes-checks.patch \
     file://amdtPwrProf_mknod.sh \
     file://amdtPwrProf.rules \
     file://codexl_remote_agent.sh \
     file://codexl-remote-agent.service \
     file://makefile-mkdir-ordering.patch;striplevel=0 \
"

inherit scons module systemd

SYSTEMD_SERVICE_${PN} = "codexl-remote-agent.service"
SYSTEMD_AUTO_ENABLE = "enable"

S = "${WORKDIR}/git"

BUILD_TYPE="release"
INSTALL_PREFIX="/opt/codexl"
OUTPUT_PREFIX="/Output_${BUILD_ARCH}/${BUILD_TYPE}/bin"

EXTRA_OESCONS = " \
    -C ${S}/CodeXL \
    CXL_common_dir=${S}/CodeXL/../Common \
    CXL_prefix=${S}/CodeXL/../ \
    CXL_build=${BUILD_TYPE} \
    CXL_boost_dir="${STAGING_DIR_TARGET}${libdir}" \
    CXL_USE_INTERNAL_LIB_GLEW="false" \
    CXL_tinyxml_dir="${STAGING_DIR_TARGET}${libdir}" \
    CXL_tinyxml_inc_dir="${STAGING_DIR_TARGET}${includedir}" \
    CXL_RA_only="true" \
    CXL_sysroot_dir=${PKG_CONFIG_SYSROOT_DIR} \
    AMDTRemoteDebuggingServer \
    VulkanEnv \
    VulkanServer \
    CapturePlayer \
    GPUPerfServer \
    AMDTPowerProfilingDrivers \
    AMDTRemoteAgent \
    Teapot \
    ClassicMatMul \
"

BACKEND_SPROOT = "${S}/CodeXL/Components/GpuProfiling/Build/../"

BACKEND_EXTRA_OESCONS = " \
    -C ${BACKEND_SPROOT}/Build \
    CXL_common_dir=${S}/CodeXL/../Common \
    CXL_prefix=${BACKEND_SPROOT} \
    CXL_build_type=static \
    CXL_boost_dir="${STAGING_DIR_TARGET}${libdir}" \
    CXL_RA_only="true" \
    CXL_sysroot_dir=${PKG_CONFIG_SYSROOT_DIR} \
"

BACKEND_PWRPROFROOT = "${S}/CodeXL/Components/PowerProfiling/Backend/AMDTPowerProfilingDrivers/Linux/"

do_compile() {
    export PYTHONPATH=${STAGING_DIR_NATIVE}/usr/lib/python2.7/site-packages/SCons/Variables/

    ${STAGING_BINDIR_NATIVE}/scons ${PARALLEL_MAKE} ${EXTRA_OESCONS} || die "codexl scons build failed."

    CWD=$(pwd)
    cd ${BACKEND_SPROOT}/Build/
    export CXL_common_dir=${S}/CodeXL/../Common
    ${STAGING_BINDIR_NATIVE}/scons ${PARALLEL_MAKE} ${BACKEND_EXTRA_OESCONS} || die "codexl gpu profile backend scons build failed."
    ./backend_build.sh skip-32bitbuild skip-framework skip-hsaprofiler boostlibdir "${STAGING_DIR_TARGET}${libdir}"

    REV=$(cat ${BACKEND_PWRPROFROOT}/CodeXLPwrProfVersion)
    tar -xpf ${BACKEND_PWRPROFROOT}/CodeXLPwrProfDriverSource.tar.gz -C ${S}/${OUTPUT_PREFIX}
    cp -a ${BACKEND_PWRPROFROOT}/Makefile ${S}/${OUTPUT_PREFIX}/amdtPwrProf-${REV}/
    cd ${S}/${OUTPUT_PREFIX}/amdtPwrProf-${REV}/
    module_do_compile
    cd ${CWD}
}

do_install() {
    install -d ${D}/home/root/.CodeXL/CodeXL

    install -d ${D}${INSTALL_PREFIX}
    install -m 755 ${S}/${OUTPUT_PREFIX}/CodeXLGpuProfiler ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/CodeXLGpuProfilerRun ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/CodeXLRemoteAgent ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/CodeXLRemoteAgent-bin ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/CXLGraphicsServer ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/CXLRemoteDebuggingServer ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/CXLGraphicsServerPlayer ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libAMDOpenCLDebugAPI64*.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLAPIClasses.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLApiFunctions.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLBaseTools.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLGpuProfilerCLOccupancyAgent.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLGpuProfilerCLProfileAgent.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLGpuProfilerCLTraceAgent.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLGpuProfilerPreloadXInitThreads.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLOSAPIWrappers.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLOSWrappers.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLPowerProfileAPI.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLProcessDebugger.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libCXLRemoteClient.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libGPUPerfAPICL.so ${D}${INSTALL_PREFIX}/
    install -m 755 ${S}/${OUTPUT_PREFIX}/libGPUPerfAPICounters.so ${D}${INSTALL_PREFIX}/
    install -m 644 ${S}/${OUTPUT_PREFIX}/CodeXLRemoteAgentConfig.xml ${D}${INSTALL_PREFIX}/
    install -m 644 ${S}/${OUTPUT_PREFIX}/amdtPwrProf-5.10/amdtPwrProf.ko ${D}${INSTALL_PREFIX}/

    install -m 755 ${WORKDIR}/amdtPwrProf_mknod.sh ${D}${INSTALL_PREFIX}/
    install -d ${D}/${sysconfdir}/udev/rules.d/
    install -m 644 ${WORKDIR}/amdtPwrProf.rules ${D}/${sysconfdir}/udev/rules.d/

    install -m 755 ${WORKDIR}/codexl_remote_agent.sh ${D}${INSTALL_PREFIX}/
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/codexl-remote-agent.service ${D}${systemd_unitdir}/system/
    sed -i -e 's,@BINDIR@,${bindir},g' \
           -e 's,@SYSCONFDIR@,${sysconfdir},g' \
           ${D}${systemd_unitdir}/system/*.service

    install -d ${D}${INSTALL_PREFIX}/CXLActivityLogger/doc
    find ${S}${OUTPUT_PREFIX}/CXLActivityLogger/doc/ -type f -exec install -m 644 {} ${D}${INSTALL_PREFIX}/CXLActivityLogger/doc/ \;

    install -d ${D}${INSTALL_PREFIX}/CXLActivityLogger/include
    find ${S}${OUTPUT_PREFIX}/CXLActivityLogger/include/ -type f -exec install -m 644 {} ${D}${INSTALL_PREFIX}/CXLActivityLogger/include/ \;

    install -d ${D}${INSTALL_PREFIX}/CXLActivityLogger/bin/x86
    find ${S}${OUTPUT_PREFIX}/CXLActivityLogger/bin/x86/ -type f -exec install -m 755 {} ${D}${INSTALL_PREFIX}/CXLActivityLogger/bin/x86/ \;

    install -d ${D}${INSTALL_PREFIX}/CXLActivityLogger/bin/x86_64
    find ${S}${OUTPUT_PREFIX}/CXLActivityLogger/bin/x86_64/ -type f -exec install -m 755 {} ${D}${INSTALL_PREFIX}/CXLActivityLogger/bin/x86_64/ \;

    install -d ${D}${INSTALL_PREFIX}/Plugins
    find ${S}${OUTPUT_PREFIX}/Plugins/ -type f -name *.so -exec install -m 755 {} ${D}${INSTALL_PREFIX}/Plugins/ \;
    find ${S}${OUTPUT_PREFIX}/Plugins/ -type f -name *.json -exec install -m 755 {} ${D}${INSTALL_PREFIX}/Plugins/ \;

    install -d ${D}${INSTALL_PREFIX}/Legal/Public
    cp -r ${S}/${OUTPUT_PREFIX}/Legal/Public/CodeXLEndUserLicenseAgreement-Linux.htm ${D}${INSTALL_PREFIX}/Legal/Public
    cp -r ${S}/${OUTPUT_PREFIX}/Legal/GNU_LESSER_GENERAL_PUBLIC_LICENSE2_1.pdf ${D}${INSTALL_PREFIX}/Legal

    install -d ${D}${INSTALL_PREFIX}/examples/Teapot/res
    install -m 644 ${S}/${OUTPUT_PREFIX}/examples/Teapot/release/CXLTeaPot-bin ${D}${INSTALL_PREFIX}/examples/Teapot
    cp -r ${S}/${OUTPUT_PREFIX}/examples/Teapot/release/res/* ${D}${INSTALL_PREFIX}/examples/Teapot/res
    install -m 644 ${S}/${OUTPUT_PREFIX}/examples/Teapot/CXLTeapotLicense.txt ${D}${INSTALL_PREFIX}/examples/Teapot
    install -m 644 ${S}/${OUTPUT_PREFIX}/CXLClassicMatMul-bin ${D}${INSTALL_PREFIX}/examples/
}

do_package_append() {
    # change examples binaries mode back to executable, this hack is required to avoid auto strip of these binaries
    pkgdest_dir = d.getVar('PKGDEST', True)

    cmd = "find %s -name %s -exec chmod 755 {} \;" \
           % (pkgdest_dir, "CXLTeaPot-bin")
    os.system(cmd);

    cmd = "find %s -name %s -exec chmod 755 {} \;" \
           % (pkgdest_dir, "CXLClassicMatMul-bin")
    os.system(cmd);
}

PACKAGES += "${PN}-examples"
FILES_${PN} += " \
    /home/root/.CodeXL/CodeXL \
    ${INSTALL_PREFIX}/CodeXLGpuProfiler \
    ${INSTALL_PREFIX}/CodeXLGpuProfilerRun \
    ${INSTALL_PREFIX}/CodeXLRemoteAgent \
    ${INSTALL_PREFIX}/CodeXLRemoteAgent-bin \
    ${INSTALL_PREFIX}/CodeXLRemoteAgentConfig.xml \
    ${INSTALL_PREFIX}/CXLGraphicsServer \
    ${INSTALL_PREFIX}/CXLRemoteDebuggingServer \
    ${INSTALL_PREFIX}/CXLGraphicsServerPlayer \
    ${INSTALL_PREFIX}/libAMDOpenCLDebugAPI64*.so \
    ${INSTALL_PREFIX}/libCXLAPIClasses.so \
    ${INSTALL_PREFIX}/libCXLApiFunctions.so \
    ${INSTALL_PREFIX}/libCXLBaseTools.so \
    ${INSTALL_PREFIX}/libCXLGpuProfilerCLOccupancyAgent.so \
    ${INSTALL_PREFIX}/libCXLGpuProfilerCLProfileAgent.so \
    ${INSTALL_PREFIX}/libCXLGpuProfilerCLTraceAgent.so \
    ${INSTALL_PREFIX}/libCXLGpuProfilerPreloadXInitThreads.so \
    ${INSTALL_PREFIX}/libCXLOSAPIWrappers.so \
    ${INSTALL_PREFIX}/libCXLOSWrappers.so \
    ${INSTALL_PREFIX}/libCXLPowerProfileAPI.so \
    ${INSTALL_PREFIX}/libCXLProcessDebugger.so \
    ${INSTALL_PREFIX}/libCXLRemoteClient.so \
    ${INSTALL_PREFIX}/libGPUPerfAPICL.so \
    ${INSTALL_PREFIX}/libGPUPerfAPICounters.so \
    ${INSTALL_PREFIX}/amdtPwrProf.ko \
    ${INSTALL_PREFIX}/amdtPwrProf_mknod.sh \
    ${sysconfdir}/udev/rules.d/amdtPwrProf.rules \
    ${INSTALL_PREFIX}/codexl_remote_agent.sh \
    ${systemd_unitdir}/system/codexl-remote-agent.service \
    ${INSTALL_PREFIX}/CXLActivityLogger/* \
    ${INSTALL_PREFIX}/Legal/* \
    ${INSTALL_PREFIX}/Legal/Public/* \
    ${INSTALL_PREFIX}/Plugins/* \
"

FILES_${PN}-examples += " \
    ${INSTALL_PREFIX}/examples/Teapot/CXLTeaPot-bin \
    ${INSTALL_PREFIX}/examples/Teapot/res/* \
    ${INSTALL_PREFIX}/examples/Teapot/CXLTeapotLicense.txt \
    ${INSTALL_PREFIX}/examples/CXLClassicMatMul-bin \
"

INSANE_SKIP_${PN} = "ldflags dev-so"
