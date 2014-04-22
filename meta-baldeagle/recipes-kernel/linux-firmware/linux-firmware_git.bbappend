FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
#
# Override LIC_FILES_SHKSUM and SRCREV to point to the correct git repository
#
SRC_URI += "file://BONAIRE_vce.bin \
	    file://HAINAN_vce.bin"

LIC_FILES_CHKSUM = "file://LICENSE.radeon;md5=07b0c31777bd686d8e1609c6940b5e74 \
                    file://LICENSE.dib0700;md5=f7411825c8a555a1a3e5eab9ca773431 \
                    file://LICENCE.xc5000;md5=1e170c13175323c32c7f4d0998d53f66 \
                    file://LICENCE.ralink-firmware.txt;md5=ab2c269277c45476fb449673911a2dfd \
                    file://LICENCE.qla2xxx;md5=f5ce8529ec5c17cb7f911d2721d90e91 \
                    file://LICENCE.iwlwifi_firmware;md5=8b938534f77ffd453690eb34ed84ae8b \
                    file://LICENCE.i2400m;md5=14b901969e23c41881327c0d9e4b7d36 \
                    file://LICENCE.atheros_firmware;md5=30a14c7823beedac9fa39c64fdd01a13 \
                    file://LICENCE.agere;md5=af0133de6b4a9b2522defd5f188afd31 \
                    file://LICENCE.rtlwifi_firmware.txt;md5=00d06cfd3eddd5a2698948ead2ad54a5 \
                    file://LICENCE.broadcom_bcm43xx;md5=3160c14df7228891b868060e1951dfbc \
                    file://LICENCE.ti-connectivity;md5=186e7a43cf6c274283ad81272ca218ea \
                    file://LICENCE.atheros_firmware;md5=30a14c7823beedac9fa39c64fdd01a13 \
                    file://LICENCE.via_vt6656;md5=e4159694cba42d4377a912e78a6e850f \
                    file://LICENCE.Marvell;md5=9ddea1734a4baf3c78d845151f42a37a \
                   "
SRCREV = "d7f8a7c81a3aaf06e4166ff17f9ef7cae831916f"

do_install_append() {
	rm ${D}/lib/firmware/radeon/RV770_me.bin
	rm ${D}/lib/firmware/radeon/RV670_me.bin
	rm ${D}/lib/firmware/radeon/RV635_pfp.bin
	rm ${D}/lib/firmware/radeon/RV630_pfp.bin
	rm ${D}/lib/firmware/radeon/RS600_cp.bin
	rm ${D}/lib/firmware/radeon/R100_cp.bin
	rm ${D}/lib/firmware/radeon/RV770_pfp.bin
	rm ${D}/lib/firmware/radeon/RS690_cp.bin
	rm ${D}/lib/firmware/radeon/RV635_me.bin
	rm ${D}/lib/firmware/radeon/RV620_pfp.bin
	rm ${D}/lib/firmware/radeon/RV620_me.bin
	rm ${D}/lib/firmware/radeon/R420_cp.bin
	rm ${D}/lib/firmware/radeon/RV610_me.bin
	rm ${D}/lib/firmware/radeon/RV730_pfp.bin
	rm ${D}/lib/firmware/radeon/R520_cp.bin
	rm ${D}/lib/firmware/radeon/R600_me.bin
	rm ${D}/lib/firmware/radeon/RV670_pfp.bin
	rm ${D}/lib/firmware/radeon/RV730_me.bin
	rm ${D}/lib/firmware/radeon/RV630_me.bin
	rm ${D}/lib/firmware/radeon/RV710_pfp.bin
	rm ${D}/lib/firmware/radeon/R300_cp.bin
	rm ${D}/lib/firmware/radeon/RV710_me.bin
	rm ${D}/lib/firmware/radeon/R200_cp.bin
	rm ${D}/lib/firmware/radeon/R600_pfp.bin
	rm ${D}/lib/firmware/radeon/RS780_pfp.bin
	rm ${D}/lib/firmware/radeon/RS780_me.bin
	rm ${D}/lib/firmware/radeon/RV610_pfp.bin

	install -m 0755 ${WORKDIR}/BONAIRE_vce.bin ${D}/lib/firmware/radeon
	chmod 644 ${D}/lib/firmware/radeon/BONAIRE_vce.bin

	install -m 0755 ${WORKDIR}/HAINAN_vce.bin ${D}/lib/firmware/radeon
	chmod 644 ${D}/lib/firmware/radeon/HAINAN_vce.bin
}

PACKAGES =+ "${PN}-radeon-license ${PN}-radeon-kaveri ${PN}-radeon-bonaire"

FILES_${PN}-bcm4329 = " \
  /lib/firmware/brcm/brcmfmac4329-sdio.bin \
"
ALTERNATIVE_TARGET_linux-firmware-bcm4329[brcmfmac-sdio.bin] = "/lib/firmware/brcm/brcmfmac4329-sdio.bin"

FILES_${PN}-bcm4330 = " \
  /lib/firmware/brcm/brcmfmac4330-sdio.bin \
"
ALTERNATIVE_TARGET_linux-firmware-bcm4330[brcmfmac-sdio.bin] = "/lib/firmware/brcm/brcmfmac4330-sdio.bin"

FILES_${PN}-bcm4334 = " \
  /lib/firmware/brcm/brcmfmac4334-sdio.bin \
"
ALTERNATIVE_TARGET_linux-firmware-bcm4334[brcmfmac-sdio.bin] = "/lib/firmware/brcm/brcmfmac4334-sdio.bin"

RDEPENDS_${PN}-radeon-kaveri = "${PN}-radeon-license"
RDEPENDS_${PN}-radeon-bonaire = "${PN}-radeon-license"

FILES_${PN}-radeon-license =   "/lib/firmware/LICENSE.radeon"

FILES_${PN}-radeon-kaveri = "/lib/firmware/radeon/KAVERI_*"
FILES_${PN}-radeon-kaveri += "/lib/firmware/radeon/HAINAN_*"

FILES_${PN}-radeon-bonaire = "/lib/firmware/radeon/BONAIRE_*"
