#!/usr/bin/env bash

#
# Update MacPorts.
#
echo "Updating MacPorts..."
sudo port selfupdate
sudo port -RNpu upgrade outdated
echo "Done updating MacPorts."

#
# Update Homebrew.
#
echo "Updating Homebrew..."
brew upgrade
brew cleanup
echo "Done updating Homebrew."

exit $?

