FILE(TO_CMAKE_PATH "$ENV{SISODIR5}" SISODIR5)

IF (GBELIB_INCLUDE_DIR AND GBELIB_LIBRARY)
	SET(GBELIB_FIND_QUIETLY TRUE)
ENDIF (GBELIB_INCLUDE_DIR AND GBELIB_LIBRARY)

FIND_PATH(GBELIB_INCLUDE_DIR gbe.h
	PATHS
	$ENV{GBELIB}/include
	${CMAKE_INSTALL_PREFIX}/include
	${SISODIR5}/include
	"[HKEY_LOCAL_MACHINE\\SOFTWARE\\Silicon Software GmbH\\Runtime5;Info]/include"
)

INCLUDE(SisoLibDir)
SISO_LIB_DIR("${SISODIR5}/lib" LIB_DIRS COMPILER_LIB_DIR)

IF (UNIX)
	SET(GBELIB_NAME gbe)
ELSE (UNIX)
	SET(GBELIB_NAME gbelib)
ENDIF (UNIX)

FIND_LIBRARY(GBELIB_LIBRARY NAMES ${GBELIB_NAME}
	PATHS
	$ENV{GBELIB}/lib/${COMPILER_LIB_DIR}
	$ENV{GBELIB}/lib
	${CMAKE_INSTALL_PREFIX}/lib/${COMPILER_LIB_DIR}
	${CMAKE_INSTALL_PREFIX}/lib
	${LIB_DIRS}
	"[HKEY_LOCAL_MACHINE\\SOFTWARE\\Silicon Software GmbH\\Runtime5;Info]/lib/${COMPILER_LIB_DIR}"
	"[HKEY_LOCAL_MACHINE\\SOFTWARE\\Silicon Software GmbH\\Runtime5;Info]/lib"
)

IF (GBELIB_INCLUDE_DIR AND GBELIB_LIBRARY)
	SET(GBE_FOUND TRUE)
ENDIF (GBELIB_INCLUDE_DIR AND GBELIB_LIBRARY)

IF (GBELIB_FOUND)
	IF (NOT GBELIB_FIND_QUIETLY)
		MESSAGE(STATUS "Found Siso GbE library: ${GBELIB_LIBRARY}")
	ENDIF (NOT GBELIB_FIND_QUIETLY)
	SET(GBELIB_LIBRARIES ${GBELIB_LIBRARY})
ELSE (GBELIB_FOUND)
	IF (GBELIB_FIND_REQUIRED)
		MESSAGE(FATAL_ERROR "Siso GbE library not found")
	ENDIF (GBELIB_FIND_REQUIRED)
ENDIF (GBELIB_FOUND)
