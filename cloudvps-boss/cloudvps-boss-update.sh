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

VERSION="1.2"

TITLE="CloudVPS Boss Upgrade ${VERSION}"

if [[ ! -f "/etc/cloudvps-boss/common.sh" ]]; then
    lerror "Cannot find /etc/cloudvps-boss/common.sh"
    exit 1
fi
source /etc/cloudvps-boss/common.sh

lecho "${TITLE} started on ${HOSTNAME} at $(date)."

pushd /tmp 

rm -rf /tmp/cloudvps-boss*

wget -O /tmp/cloudvps-boss.tar.gz http://cdn.duplicity.so/cloudvps-boss_latest.tar.gz
if [[ $? -ne 0 ]]; then
    lecho "Download of cloudvps-boss failed. Check firewall and network connectivity."
    exit 1
fi

tar -xf cloudvps-boss.tar.gz
if [[ $? -ne 0 ]]; then
    lecho "Extraction of cloudvps-boss failed."
    rm -rf /tmp/cloudvps-boss.tar.gz
    exit 1
fi
popd

pushd /tmp/cloudvps-boss
bash install.sh
if [[ $? -ne 0 ]]; then
    lecho "Upgrade of cloudvps-boss failed."
    rm -rf /tmp/cloudvps-boss
    exit 1
fi
popd
lecho "Removing temp files"
rm -rf /tmp/cloudvps-boss
rm -rf /tmp/cloudvps-boss.tar.gz

lecho "${TITLE} ended on ${HOSTNAME} at $(date)."