#!/bin/sh

mkdir -p ~/.nixpkgs
mkdir -p ~/.nix-channels

# Configure the channels

if ! grep -q nix-darwin ~/.nix-channels; then
  echo "https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin" >> ~/.nix-channels
fi

export NIX_PATH=darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH
export NIX_PATH=darwin-config=$HOME/Repos/dot-files/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH

if ! grep -q home-manager ~/.nix-channels; then
  echo "https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager" >> ~/.nix-channels
fi

export NIX_PATH=home-manager=$HOME/.nix-defexpr/channels/home-manager:$NIX_PATH

nix-channel --update

nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

darwin-rebuild build --flake ./\#mimer
darwin-rebuild switch --flake ./\#mimer
