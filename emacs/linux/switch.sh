#!/usr/bin/env bash

experimental_config="${HOME}/git_tree/dotfiles/emacs/linux/config-minimal-lsp.el"
stable_config="${HOME}/git_tree/dotfiles/emacs/linux/config.el"
config_symlink="${HOME}/.config/emacs/config.el"

ls -l ${config_symlink} | awk '{print $11}' | fgrep config.el 2>&1 >/dev/null
if [ $? -eq 0 ] ; then
    current_config=stable
else
    current_config=experimental
fi

rm ~/.config/emacs/config.el

if [ "$current_config" == "stable" ] ; then
    ln -s "$experimental_config" "$config_symlink"
else
    ln -s "$stable_config" "$config_symlink"
fi
