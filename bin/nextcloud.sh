#!/bin/bash

# Syncrhonize files and folders.
/usr/bin/nextcloudcmd -u $(pass webo.hosting/username) -p $(pass webo.hosting/password) /mnt/data/cloud https://nextcloud03.webo.hosting/remote.php/webdav

# Synchronize calendars and contacts.
/usr/bin/vdirsyncer sync
