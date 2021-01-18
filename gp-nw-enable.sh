#!/usr/bin/env bash

bash /opt/paloaltonetworks/globalprotect/network/config/rt-install.sh
unlink /etc/resolv.conf
cat /opt/paloaltonetworks/globalprotect/network/config/resolv_conf_head /opt/paloaltonetworks/globalprotect/network/config/resolv_conf_base > /etc/resolv.conf
