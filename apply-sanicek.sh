#!/bin/sh
pushd ~/nix-config
home-manager switch -f ./users/sanicek/home.nix
popd
