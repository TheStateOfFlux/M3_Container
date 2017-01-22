#!/bin/sh

# download link for the sources to be stored in dl directory
PKG_DOWNLOAD="https://bootstrap.pypa.io/get-pip.py"

# md5 checksum of archive in dl directory
PKG_CHECKSUM="none"

# name of directory after extracting the archive in working directory
PKG_DIR="get-pip.py"

# name of the archive in dl directory
PKG_ARCHIVE_FILE="${PKG_DIR}"

SCRIPTSDIR="$(dirname $0)"
HELPERSDIR="${SCRIPTSDIR}/helpers"
TOPDIR="$(realpath ${SCRIPTSDIR}/../..)"

. ${TOPDIR}/scripts/common_settings.sh
. ${HELPERSDIR}/functions.sh

PKG_ARCHIVE="${DOWNLOADS_DIR}/${PKG_ARCHIVE_FILE}"
PKG_SRC_DIR="${SOURCES_DIR}/${PKG_DIR}"
PKG_BUILD_DIR="${BUILD_DIR}/${PKG_DIR}"
PKG_INSTALL_DIR="${PKG_BUILD_DIR}/install"

check_source()
{
    echo -en "\nSource check is disabled as this script will download the latest available version of get-pip.py.\n"
    true
}

unpack()
{
    # this is a special case: the downloaded file is not an archive. It is a python script that contains an base85 encoded zip. It just must be copied to the rootfs_staging
    true
}

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
    cp "${DOWNLOADS_DIR}/${PKG_ARCHIVE_FILE}" "${STAGING_DIR}/bin"
    chmod 755 "${STAGING_DIR}/bin/${PKG_ARCHIVE_FILE}"
    echo -en "\nTo install pip execute \"/bin/get-pip.sh\" after logging into the container as root.\n"
    echo -en "The container must have internet connection. The script will install pip, wheel and setuptools.\n"
}

uninstall_staging()
{
    rm "${STAGING_DIR}/bin/${PKG_ARCHIVE_FILE}"
}

. ${HELPERSDIR}/call_functions.sh
