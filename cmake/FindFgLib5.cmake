FILE(TO_CMAKE_PATH "$ENV{SISODIR5}" SISODIR5)

FIND_PATH(FgLib5_INCLUDE_DIR fgrab_define.h
	PATHS
	"$ENV{FGLIB5}/include"
	"${CMAKE_INSTALL_PREFIX}/include"
	"${SISODIR5}/include"
	"[HKEY_LOCAL_MACHINE\\SOFTWARE\\Silicon Software GmbH\\Runtime5;Info]/include"
)

INCLUDE(SisoLibDir)
SISO_LIB_DIR("${SISODIR5}/lib" LIB_DIRS COMPILER_LIB_DIR)

FIND_LIBRARY(FgLib5_LIBRARY NAMES fglib5
	PATHS
	"$ENV{FGLIB5}/lib"
	"$ENV{FGLIB5}"
	"${CMAKE_INSTALL_PREFIX}/lib"
	${LIB_DIRS}
	"[HKEY_LOCAL_MACHINE\\SOFTWARE\\Silicon Software GmbH\\Runtime5;Info]/lib/${COMPILER_LIB_DIR}"
	"[HKEY_LOCAL_MACHINE\\SOFTWARE\\Silicon Software GmbH\\Runtime5;Info]/lib"
)

IF (FgLib5_INCLUDE_DIR AND EXISTS "${FgLib5_INCLUDE_DIR}/fgrab_define.h")
	FILE(STRINGS "${FgLib5_INCLUDE_DIR}/fgrab_define.h" FGLIB_H_VERSION REGEX "^#define[ \\t]*FGLIB_VERSION_STRING[ \\t]*\"[^\"]*\"")
	IF (FGLIB_H_VERSION)
		STRING(REGEX REPLACE "^#define FGLIB_VERSION_STRING[ \\t]*\"([^\"]*)\".*" "\\1" FgLib5_VERSION_STRING "${FGLIB_H_VERSION}")
	ENDIF (FGLIB_H_VERSION)
ENDIF (FgLib5_INCLUDE_DIR AND EXISTS "${FgLib5_INCLUDE_DIR}/fgrab_define.h")

INCLUDE(FindPackageHandleStandardArgs)
IF (CMAKE_VERSION VERSION_LESS 2.8.4)
	FIND_PACKAGE_HANDLE_STANDARD_ARGS(FgLib5 DEFAULT_MSG FGLIB5_LIBRARY FGLIB5_INCLUDE_DIR)
ELSE (CMAKE_VERSION VERSION_LESS 2.8.4)
	FIND_PACKAGE_HANDLE_STANDARD_ARGS(FgLib5
			REQUIRED_VARS FgLib5_LIBRARY FgLib5_INCLUDE_DIR
			VERSION_VAR FgLib5_VERSION_STRING)
ENDIF (CMAKE_VERSION VERSION_LESS 2.8.4)

SET(FgLib5_LIBRARIES ${FgLib5_LIBRARY})

# backward compatibility
SET(FGLIB5_LIBRARY ${FgLib5_LIBRARY})
SET(FGLIB5_LIBRARIES ${FgLib5_LIBRARIES})
SET(FGLIB5_INCLUDE_DIR ${FgLib5_INCLUDE_DIR})
SET(FGLIB5_FOUND ${FgLib5_FOUND})
