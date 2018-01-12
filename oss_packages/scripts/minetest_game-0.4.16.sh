#!/bin/sh

# name of directory after extracting the archive in working directory
PKG_DIR="minetest_game-0.4.16"

# name of the archive in dl directory (use "none" if empty)
PKG_ARCHIVE_FILE="${PKG_DIR}.tar.gz"

# download link for the sources to be stored in dl directory (use "none" if empty)
# PKG_DOWNLOAD="https://github.com/minetest/minetest_game/archive/0.4.16.tar.gz"
PKG_DOWNLOAD="https://m3-container.net/M3_Container/oss_packages/${PKG_ARCHIVE_FILE}"

# md5 checksum of archive in dl directory (use "none" if empty)
PKG_CHECKSUM="e97efb4618f345ae3039af7ba844fb9c"



SCRIPTSDIR=$(dirname $0)
HELPERSDIR="${SCRIPTSDIR}/helpers"
TOPDIR=$(realpath ${SCRIPTSDIR}/../..)
. "${TOPDIR}/scripts/common_settings.sh"
. "${HELPERSDIR}/functions.sh"
PKG_ARCHIVE="${DOWNLOADS_DIR}/${PKG_ARCHIVE_FILE}"
PKG_SRC_DIR="${SOURCES_DIR}/${PKG_DIR}"
PKG_BUILD_DIR="${BUILD_DIR}/${PKG_DIR}"
PKG_INSTALL_DIR="${PKG_BUILD_DIR}/install"

configure()
{
    true
}

compile()
{
    true
}

install_staging()
{   
    mkdir -p "${STAGING_DIR}/usr/local/games"
    cp -r "${PKG_BUILD_DIR}" "${STAGING_DIR}/usr/local/games/minetest_game"
}

uninstall_staging()
{   
    rm -rf "${STAGING_DIR}/usr/local/games/minetest_game"
}

. ${HELPERSDIR}/call_functions.sh