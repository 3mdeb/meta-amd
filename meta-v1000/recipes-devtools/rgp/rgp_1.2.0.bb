SUMMARY = "Radeon-GPUProfiler"
DESCRIPTION = "The Radeon GPU Profiler (RGP) is a ground-breaking \
              low-level optimization tool from AMD.  It provides \
              detailed timing information on Radeon Graphics \
              using custom, built-in, hardware thread-tracing, \
              allowing the developer deep inspection of GPU workloads. \
              This package merely deploys the remote profiling service \
              on the target so a host can collect and display profiling \
              data."

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://License.rtf;md5=5441ae9fb95849e3aacd0f330710f9fa"

inherit systemd

RDEPENDS_${PN} += "connman-wait-online"

SRC_URI = "file://License.rtf \
           file://RadeonDeveloperServiceCLI \
           file://${BOOT_SERVICE}"

S = "${WORKDIR}"
BOOT_SERVICE = "rds-cli.service"
SYSTEMD_SERVICE_${PN} = "${BOOT_SERVICE}"
SYSTEMD_AUTO_ENABLE = "enable"

# Skip configure and compile
do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    # Install the binary for RDS CLI
    install -d ${D}${bindir}
    install -m 0755 ${S}/RadeonDeveloperServiceCLI ${D}${bindir}/

    # Install the systemd service so we can kick start on boot
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/${BOOT_SERVICE} ${D}${systemd_unitdir}/system/
}
