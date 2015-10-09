# This is a strict hack for CB version 2014.11-101
# the debugger points to /usr/lib6464 rather than
# to /usr/lib64 so we create a symlink to work around
# the issue for the time being
do_install_append_amd() {
	ln -s ${libdir} ${D}/${libdir}64
}
FILES_gdbserver_append_amd = " ${libdir}64 "
