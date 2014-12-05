# Backported from poky/master:
#     http://git.yoctoproject.org/cgit.cgi/poky/commit/?h=master-next&id=5fe3954013771a9f1cd1df63a6fd6ca5c470c7ad

# Where to find perl @INC/#include files
# - use the -native versions not those from the target build
export PERL_LIB = "${STAGING_LIBDIR_NATIVE}/perl-native/perl/${PV}/"
export PERL_ARCHLIB = "${STAGING_LIBDIR_NATIVE}/perl-native/perl/${PV}/"
