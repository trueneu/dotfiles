#!/usr/bin/env bash

bash /opt/paloaltonetworks/globalprotect/network/config/rt-uninstall.sh
rm /etc/resolv.conf
ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
