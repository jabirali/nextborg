# Backup server

These are my backup server dotfiles, which take daily snapshots 
of mail, calendars, contacts, and Nextcloud/Syncthing shares.

## Prerequisites

The scripts and instructions here assume you have an Ubuntu server with:

- A dedicated user named `syncing` to run all your sync daemons;
- A user-writable partition in `/mnt/data` to sync your data to;
- A root-writable partition in `/mnt/borg` to backup this data;
- A "password store" (`gpg` + `pass`) setup for user `syncing`.

To get started, you first have to install some system dependencies:

    sudo apt install borgmatic vdirsyncer offlineimap nextcloud-desktop-cmd syncthing ufw

## User setup

Clone this repository into e.g. `~/.dotfiles`, then symlink into place:

    ln -s ~/.dotfiles/bin ~/.local/bin
    ln -s ~/.dotfiles/config ~/.config

Perform initial synchronization of DAV and IMAP services to check setup:

    vdirsyncer discover
    vdirsyncer sync
    offlineimap

## Root setup

Recursively copy all files in `~/.dotfiles/etc` into place:

    sudo cp -r ~/.dotfiles/etc/borgmatic /etc/
    sudo cp ~/.dotfiles/etc/systemd/system/* /etc/systemd/system/

Then enable all the relevant services:

    sudo systemctl enable syncthing.service offlineimap.service nextcloud.timer borgmatic.timer
