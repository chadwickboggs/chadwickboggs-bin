#!/usr/bin/env bash

#
# Update Homebrew.
#
echo "Updating Homebrew..."
brew upgrade
brew cleanup
echo "Done updating Homebrew."

#
# Update MacPorts.
#
echo "Updating MacPorts..."
sudo port selfupdate
sudo port -RNpu upgrade outdated
echo "Done updating MacPorts."

exit $?

