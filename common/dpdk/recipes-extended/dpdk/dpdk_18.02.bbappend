FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
            file://dpdk-dev-v4-01-20-crypto-ccp-add-AMD-ccp-skeleton-PMD.patch \
            file://dpdk-dev-v4-02-20-crypto-ccp-support-ccp-device-initialization-and-deintialization.patch \
            file://dpdk-dev-v4-03-20-crypto-ccp-support-basic-pmd-ops.patch \
            file://dpdk-dev-v4-04-20-crypto-ccp-support-session-related-crypto-pmd-ops.patch \
            file://dpdk-dev-v4-05-20-crypto-ccp-support-queue-pair-related-pmd-ops.patch \
            file://dpdk-dev-v4-06-20-crypto-ccp-support-crypto-enqueue-and-dequeue-burst-api.patch \
            file://dpdk-dev-v4-07-20-crypto-ccp-support-sessionless-operations.patch \
            file://dpdk-dev-v4-08-20-crypto-ccp-support-stats-related-crypto-pmd-ops.patch \
            file://dpdk-dev-v4-09-20-crypto-ccp-support-ccp-hwrng-feature.patch \
            file://dpdk-dev-v4-10-20-crypto-ccp-support-aes-cipher-algo.patch \
            file://dpdk-dev-v4-11-20-crypto-ccp-support-3des-cipher-algo.patch \
            file://dpdk-dev-v4-12-20-crypto-ccp-support-aes-cmac-auth-algo.patch \
            file://dpdk-dev-v4-13-20-crypto-ccp-support-aes-gcm-aead-algo.patch \
            file://dpdk-dev-v4-14-20-crypto-ccp-support-sha1-authentication-algo.patch \
            file://dpdk-dev-v4-15-20-crypto-ccp-support-sha2-family-authentication-algo.patch \
            file://dpdk-dev-v4-16-20-crypto-ccp-support-sha3-family-authentication-algo.patch \
            file://dpdk-dev-v4-17-20-crypto-ccp-support-cpu-based-md5-and-sha2-family-authentication-algo.patch \
            file://dpdk-dev-v4-18-20-test-crypto-add-test-for-AMD-CCP-crypto-poll-mode.patch \
            file://dpdk-dev-v4-19-20-doc-add-document-for-AMD-CCP-crypto-poll-mode-driver.patch \
            file://dpdk-dev-v4-20-20-crypto-ccp-moved-license-headers-to-SPDX-format.patch \
            file://dpdk-dev-v3-01-18-net-axgbe-add-minimal-dev-init-and-uninit-support.patch \
            file://dpdk-dev-v3-02-18-net-axgbe-add-register-map-and-related-macros.patch \
            file://dpdk-dev-v3-03-18-net-axgbe-add-phy-register-map-and-helper-macros.patch \
            file://dpdk-dev-v3-04-18-net-axgbe-add-structures-for-MAC-initialization-and-reset.patch \
            file://dpdk-dev-v3-05-18-net-axgbe-add-phy-initialization-and-related-apis.patch \
            file://dpdk-dev-v3-06-18-net-axgbe-add-phy-programming-apis.patch \
            file://dpdk-dev-v3-07-18-net-axgbe-add-interrupt-handler-for-autonegotiation.patch \
            file://dpdk-dev-v3-08-18-net-axgbe-add-transmit-and-receive-queue-setup-apis.patch \
            file://dpdk-dev-v3-09-18-net-axgbe-add-DMA-programming-and-dev-start-and-stop-apis.patch \
            file://dpdk-dev-v3-10-18-net-axgbe-add-transmit-and-receive-data-path-apis.patch \
            file://dpdk-dev-v3-11-18-doc-add-documents-for-AMD-axgbe-Ethernet-PMD.patch \
            file://dpdk-dev-v3-12-18-net-axgbe-add-link-status-update.patch \
            file://dpdk-dev-v3-13-18-net-axgbe-add-configure-flow-control-while-link-adjustment.patch \
            file://dpdk-dev-v3-14-18-net-axgbe-add-promiscuous-mode-support.patch \
            file://dpdk-dev-v3-15-18-net-axgbe-add-generic-transmit-and-receive-stats-support.patch \
            file://dpdk-dev-v3-16-18-net-axgbe-add-support-for-build-32-bit-mode.patch \
            file://dpdk-dev-v3-17-18-net-axgbe-add-workaround-for-axgbe-ethernet-training-bug.patch \
            file://dpdk-dev-v3-18-18-net-axgbe-moved-license-headers-to-SPDX-format.patch \
            file://0001-crypto-ccp-fix-shared-libs-build.patch \
            file://0002-net-axgbe-fix-shared-libs-build.patch \
"

# takes n or y
BUILD_SHARED = "n"
do_configure_prepend () {
	# enable the AMD CCP driver
	sed -e "s#CONFIG_RTE_LIBRTE_PMD_CCP=n#CONFIG_RTE_LIBRTE_PMD_CCP=y#" -i ${S}/config/common_base
	sed -e "s#CONFIG_RTE_LIBRTE_PMD_CCP_CPU_AUTH=n#CONFIG_RTE_LIBRTE_PMD_CCP_CPU_AUTH=y#" -i ${S}/config/common_base

	# shared libs are a more convenient way for development but then the user
	# has to load the PMD explicitly with the -d flag so be careful
	sed -e "s#CONFIG_RTE_BUILD_SHARED_LIB=n#CONFIG_RTE_BUILD_SHARED_LIB=${BUILD_SHARED}#" -i ${S}/config/common_base
}

COMPATIBLE_MACHINE_snowyowl = "snowyowl"
TUNE_FEATURES += "m64"
