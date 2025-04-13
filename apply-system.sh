#!/bin/sh
pushd ~/nix-config
nixos-rebuild switch --use-remote-sudo -I nixos-config=./system/configuration.nix
popd
