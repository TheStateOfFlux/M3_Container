#!/bin/sh

# name of directory after extracting the archive in working directory
PKG_DIR="v2.0.0"


# name of the archive in dl directory
PKG_ARCHIVE_FILE="${PKG_DIR}.tar.gz"

# download link for the sources to be stored in dl directory
PKG_DOWNLOAD="https://github.com/mz-automation/lib60870/archive/${PKG_ARCHIVE_FILE}"

# md5 checksum of archive in dl directory
PKG_CHECKSUM="a69fd037862ac8c0d4c093f1c13a16c2"


SCRIPTSDIR=$(dirname $0)
HELPERSDIR="${SCRIPTSDIR}/helpers"
TOPDIR=$(realpath ${SCRIPTSDIR}/../..)
. ${TOPDIR}/scripts/common_settings.sh
. ${HELPERSDIR}/functions.sh
PKG_ARCHIVE="${DOWNLOADS_DIR}/${PKG_ARCHIVE_FILE}"
PKG_SRC_DIR="${SOURCES_DIR}/${PKG_DIR}"
PKG_BUILD_DIR="${BUILD_DIR}/lib60870-2.0.0/lib60870-C"
PKG_STATIC_LIB_DIR="${PKG_BUILD_DIR}/build"
PKG_API_HEADERS_DIR="${PKG_BUILD_DIR}/src/inc/api"

configure()
{
	return
}

compile()
{
    copy_overlay
    cd "${PKG_BUILD_DIR}"
    make ${M3_MAKEFLAGS} V=1 || exit_failure "failed to build ${PKG_DIR}"

	#if you need example binarys just switch to the example directory and make the instance you need (client, server...)
	
}

install_staging()
{
	#copy static lib
	mkdir -p "${STAGING_DIR}/lib"
    cp "${PKG_STATIC_LIB_DIR}/lib60870.a" "${STAGING_DIR}/lib/"
    
    #copy all api headers
    mkdir -p "${STAGING_DIR}/include/lib60870"
    cp -a "${PKG_API_HEADERS_DIR}/." "${STAGING_DIR}/include/lib60870/"

}

. ${HELPERSDIR}/call_functions.sh
