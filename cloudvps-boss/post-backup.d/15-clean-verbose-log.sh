#!/bin/bash
# CloudVPS Boss - Duplicity wrapper to back up to OpenStack Swift
# Copyright (C) 2014 CloudVPS. (CloudVPS Backup to Object Store Script)
# Author: Remy van Elst, https://raymii.org
# 
# This program is free software; you can redistribute it and/or modify it 
# under the terms of the GNU General Public License as published by the 
# Free Software Foundation; either version 2 of the License, or (at your 
# option) any later version.
# 
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along 
# with this program; if not, write to the Free Software Foundation, Inc., 
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
# 

VERSION="1.6"
TITLE="CloudVPS Boss Log Clean ${VERSION}"

if [[ ! -f "/etc/cloudvps-boss/common.sh" ]]; then
    lerror "Cannot find /etc/cloudvps-boss/common.sh"
    exit 1
fi
source /etc/cloudvps-boss/common.sh

if [[ -f "/var/log/duplicity.log" ]]; then
    # If it's larger than 128 MB
    if [[ "$(wc -c /var/log/duplicity.log)" > "134217728" ]]; then
        log "strace log larger than 128MB, cleaning up."
        echo " " > /var/log/duplicity.log
    fi
fi