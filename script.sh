#!/bin/sh
set -e

echo '::group::🐶 Installing shfmt ... https://github.com/mvdan/sh'
TEMP_PATH="$(mktemp -d)"
$GITHUB_ACTION_PATH/install_shfmt.sh -b "${TEMP_PATH}"
echo '::endgroup::'
echo "${TEMP_PATH}" >>"${GITHUB_PATH}"
