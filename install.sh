#!/bin/bash

# define constants
GITHUB_REPO="hieuphq/sol-anchor"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="anchor-wrapper.sh"
BIN_NAME="anchor-wrapper"
SCRIPT_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/main/${SCRIPT_NAME}"

# check if installation directory exists and is writable
if [ ! -w "${INSTALL_DIR}" ]; then
  echo "Installation directory ${INSTALL_DIR} does not exist or is not writable. Please run this script as root or provide a different installation directory."
  exit 1
fi

# download script
echo "Downloading ${SCRIPT_NAME} from ${SCRIPT_URL}..."
if ! curl -sSf "${SCRIPT_URL}" > "${INSTALL_DIR}/${BIN_NAME}"; then
  echo "Failed to download ${SCRIPT_NAME}."
  exit 1
fi

# make script executable
echo "Making ${BIN_NAME} executable..."
chmod +x "${INSTALL_DIR}/${BIN_NAME}"

# display success message
echo "Successfully installed ${BIN_NAME} to ${INSTALL_DIR}."
