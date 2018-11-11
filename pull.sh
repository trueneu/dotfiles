#!/usr/bin/env zsh

source lists.sh

for directory_whole in $DIRECTORIES_WHOLE ; do
    bn=$(basename "${directory_whole}")
    dn=$(dirname "${directory_whole}")
    cp -r "${REPO_PATH}/${bn}" "${dn}/"
done

for filename in $FILES ; do
    bn=$(basename "${filename}")
    dn=$(dirname "${filename}")
    mkdir -p "${dn}"
    cp "${REPO_PATH}/${bn}" "${dn}/${bn}"
done
