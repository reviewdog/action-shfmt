#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

# Word-split path with globbing off: a value like '*.sh' reaches shfmt literally,
# and an empty or whitespace-only value leaves no paths. An unset INPUT_PATH
# keeps the old behaviour of formatting the whole workdir.
set -f
# shellcheck disable=SC2086
set -- ${INPUT_PATH-.}
set +f
if [ $# -eq 0 ]; then
  echo 'path is empty, so there is nothing to format. Skipping shfmt.'
  exit 0
fi

echo '::group::🐶 Installing shfmt ... https://github.com/mvdan/sh'
TEMP_PATH="$(mktemp -d)"
"${GITHUB_ACTION_PATH}/install_shfmt.sh" -b "${TEMP_PATH}"
echo '::endgroup::'

# shellcheck disable=SC2086
"${TEMP_PATH}/shfmt" ${INPUT_SHFMT_FLAGS} -w -- "$@"
