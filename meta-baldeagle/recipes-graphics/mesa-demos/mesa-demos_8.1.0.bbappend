PACKAGECONFIG[glut] = "--with-glut=${STAGING_EXECPREFIXDIR},--without-glut,"
DEPENDS_baldeagle += "mesa-glut glew"
PACKAGECONFIG_append_baldeagle = " glut"
