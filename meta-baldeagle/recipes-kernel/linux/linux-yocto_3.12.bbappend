FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://defconfig \
	   file://0046-yocto-poky-dora-10.0.0-amd-staging-add-support-to-enable-and-disable-IMC-to-fetch-BIOS-code.patch \
	   file://0047-yocto-poky-dora-10.0.0-amd-i2c-dev-add-calls-to-enable-and-disable-IMC-from-fetching-BIOS-code.patch \
"
