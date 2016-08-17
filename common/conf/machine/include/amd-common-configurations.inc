POKY_DEFAULT_DISTRO_FEATURES_remove = "wayland"

PREFERRED_PROVIDER_jpeg ?= "jpeg"
PREFERRED_PROVIDER_jpeg-native ?= "jpeg-native"
PREFERRED_PROVIDER_llvm ?= "llvm3.7.1"
PREFERRED_VERSION_linux-yocto ?= "4.1%"
PREFERRED_VERSION_mesa ?= "11.0.8+git%"
PREFERRED_VERSION_gstreamer1.0-omx ?= "git+git%"
PREFERRED_VERSION_libav ?= "9.18"

MULTILIBS ?= ""
require conf/multilib.conf

MACHINE_FEATURES += "wifi efi pcbios alsa"

# QEMU does not support some of the enhanced instructions available
# on the AMD chips which causes some build time failures.
MACHINE_FEATURES_remove = "qemu-usermode"

MACHINE_EXTRA_RRECOMMENDS += "kernel-modules alsa-utils"
MACHINE_EXTRA_RRECOMMENDS += "vdpauinfo grub parted util-linux-blkid"
MACHINE_EXTRA_RRECOMMENDS += "rtc-test watchdog-test spi-test smbus-test gpio-test"
MACHINE_EXTRA_RRECOMMENDS += "amd-wdt amd-spi"
MACHINE_EXTRA_RRECOMMENDS += "${@bb.utils.contains_any("DISTRO", "mel mel-lite", "firmware-wireless", "", d)}"

RELEASE_IMAGE ?= "core-image-sato"

# Make sure the kernel messages go to the VGA console
APPEND += "console=tty0"

# Make sure the VESA VGA driver goes up on boot, we provide a generic mode here
APPEND += "vga=802"

EXTRA_OECONF_append_pn-matchbox-panel-2 = " --with-battery=acpi"

# Once we switch to using the xserver-nodm-init version
# from poky, following lines should be dropped
# Currently there's a debian packaging issue with it
VIRTUAL-RUNTIME_xserver_common_pn-packagegroup-core-x11 = "xserver-common"
PREFERRED_VERSION_xserver-nodm-init ?= "2.0"
