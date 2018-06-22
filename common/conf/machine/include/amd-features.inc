# This file defines AMD Features that can be added as EXTRA_IMAGE_FEATURES to
# different machines based on what is supported on a machine. This gives a broad
# flexibility and control over packages being installed on a machine for any image
# without needing to create bbappends for all the images that are to be supported.
#
# > Each feature can contain packages and packagegroups as its components.
# > Feature components can be dependent on DISTRO, IMAGE_FEATURE, or any variable
#   in general. e.g.: Components of "amd-feature-graphics" may be dependent on
#   "x11-base" as an IMAGE_FEATURE. Some packages may only be included for a
#   specific DISTRO. Some packages may only be installed if user allows them in
#   local.conf etc.
# > Each machine must add the required features to EXTRA_IMAGE_FEATURES in its
#   own machine config file.
# > All required features must be added to a machine regardless of the image
#   being built, but make sure that feature components are included based on
#   dependency conditions. e.g. say "amd-feature-graphics" was added to a machine
#   that supported graphics, but components of this feature must not be installed
#   on an image that is only console based such as "core-image-base", therefore
#   such components must depend on an IMAGE_FEATURE that is based on graphics
#   such as "x11-base".
# > Each machine can also override feature components in its own machine config 
#   when adding the feature to EXTRA_IMAGE_FEATURES. e.g.: A feature may be added
#   to a specific machine with minimal (or extended) packages based on requirement.
#
# Features are classified as:
#
# * amd-common-pkgs		: Common packages to be added to all machines
# * amd-feature-multimedia	: Multimedia packages (it does not depend on graphics because a machine may not have a GUI but could play videos and sounds from console)
# * amd-feature-graphics	: Graphics packages
# * amd-feature-networking	: Networking packages
# * amd-feature-debug-profile	: Debugging and Profiling tools
# * <add more features here>	: <feature summary>

# Add common feartures to be supported for all machines here
EXTRA_IMAGE_FEATURES += "amd-common-pkgs amd-feature-multimedia"

GSTREAMER_PKGS ?= " \
    ${@bb.utils.contains("IMAGE_FEATURES", "x11-base", "gstreamer1.0-meta-x11-base", "", d)} \
    ${@bb.utils.contains("IMAGE_FEATURES", "tools-audio", "gstreamer1.0-meta-audio", "", d)} \
    gstreamer1.0-meta-debug \
    gstreamer1.0-meta-video \
    gstreamer1.0-omx \
    gstreamer1.0-vaapi \
"
VULKAN_PKGS ?= ""
CODEXL_PKGS ?= ""
DPDK_PKGS ?= ""

# Additional packages can be added to the following feature specific
# variables from each machine's config file
AMD_FEATURE_MULTIMEDIA_PKGS ?= ""
AMD_FEATURE_GRAPHICS_PKGS ?= ""
AMD_FEATURE_NETWORKING_PKGS ?= ""
AMD_FEATURE_DEBUG_PROFILE_PKGS ?= ""

FEATURE_PACKAGES_amd-common-pkgs = "\
    bc \
"

FEATURE_PACKAGES_amd-feature-multimedia = "\
    ${@bb.utils.contains("DISTRO", "mel", "${GSTREAMER_PKGS}", "", d)} \
    ${AMD_FEATURE_MULTIMEDIA_PKGS} \
"

FEATURE_PACKAGES_amd-feature-graphics = "\
    ${@bb.utils.contains("INCLUDE_VULKAN", "yes", "${VULKAN_PKGS}", "", d)} \
    ${AMD_FEATURE_GRAPHICS_PKGS} \
"
FEATURE_PACKAGES_amd-feature-graphics_append_amdgpu = " mesa-demos"
FEATURE_PACKAGES_amd-feature-graphics_append_radeon = " mesa-demos"

FEATURE_PACKAGES_amd-feature-networking = "\
    ${@bb.utils.contains("DISTRO", "mel", "${DPDK_PKGS} strongswan", "", d)} \
    ${AMD_FEATURE_NETWORKING_PKGS} \
"

FEATURE_PACKAGES_amd-feature-debug-profile = "\
    ${@bb.utils.contains("INCLUDE_CODEXL", "yes", "${CODEXL_PKGS}", "", d)} \
    ${AMD_FEATURE_DEBUG_PROFILE_PKGS} \
"
