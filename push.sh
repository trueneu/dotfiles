#!/usr/bin/env zsh

source lists.sh

for directory_whole in $DIRECTORIES_WHOLE ; do
    bn=$(basename "${directory_whole}")
    dn=$(dirname "${directory_whole}")
    cp -r "${dn}/${bn}" "${REPO_PATH}/"
done

for filename in $FILES ; do
    bn=$(basename "${filename}")
    dn=$(dirname "${filename}")
    cp "${dn}/${bn}" "${REPO_PATH}/"
done

