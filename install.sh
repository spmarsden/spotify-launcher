#!/usr/bin/env bash

# Check that it is running as root.
if [ $(id -u) -ne 0 ]; then
    echo "ERROR: This script must be run as root." 1>&2
    exit 1
fi

# Check that Spotify is installed.
if ! which spotify &> /dev/null
then
    echo "ERROR: Spotify must be installed first." 1>&2
    exit 1
fi

# Remove the Spotify desktop file.
sudo mv /usr/share/applications/spotify.desktop /usr/share/applications/spotify.desktop.bak &> /dev/null

# Record and errors.
HAS_ERROR=0

# Link the new desktop file.
if ! sudo ln -sf $PWD/spotify-launcher.desktop /usr/share/applications/
then
    HAS_ERROR=1
fi

# Link the new executable.
if ! sudo ln -sf $PWD/spotify-launcher /usr/bin/
then
    HAS_ERROR=1
fi

exit $HAS_ERROR