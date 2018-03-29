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
            "

do_configure_prepend () {
	# enable the AMD CCP driver
	sed -e "s#CONFIG_RTE_LIBRTE_PMD_CCP=n#CONFIG_RTE_LIBRTE_PMD_CCP=y#" -i ${S}/config/common_base
	sed -e "s#CONFIG_RTE_LIBRTE_PMD_CCP_CPU_AUTH=n#CONFIG_RTE_LIBRTE_PMD_CCP_CPU_AUTH=y#" -i ${S}/config/common_base
}

COMPATIBLE_MACHINE_snowyowl = "snowyowl"
TUNE_FEATURES += "m64"
