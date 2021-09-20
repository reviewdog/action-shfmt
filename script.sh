#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

echo '::group::🐶 Installing shfmt ... https://github.com/mvdan/sh'
TEMP_PATH="$(mktemp -d)"
"${GITHUB_ACTION_PATH}/install_shfmt.sh" -b "${TEMP_PATH}"
echo '::endgroup::'

# shellcheck disable=SC2086
"${TEMP_PATH}/shfmt" ${INPUT_SHFMT_FLAGS} -w .
