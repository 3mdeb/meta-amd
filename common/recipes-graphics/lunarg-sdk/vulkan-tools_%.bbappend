QTBITS ?= "${@bb.utils.contains('BBFILE_COLLECTIONS', 'qt5-layer', 'cmake_qt5', '',d)}"

inherit ${QTBITS}

DEPENDS += "${@base_conditional('QTBITS', '', '', 'libxcb', d)}"
RDEPENDS_${PN}_append = " ${@base_conditional('QTBITS', '', '', 'qtsvg', d)}"

do_install_append() {
    if [ "${QTBITS}" != "" ]
    then
        install ${B}/vktrace/vktraceviewer ${D}${bindir}
    fi
}
