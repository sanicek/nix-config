{ config, pkgs, lib, ... }:

{
  home.username = "sanicek";
  home.homeDirectory = "/home/sanicek";

  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ./conf.d/bash.nix
      ./conf.d/git.nix
      ./conf.d/kitty.nix
    ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true; # VS Code is synced via github account
  };


  home.packages = with pkgs; [
    google-chrome
    gnomeExtensions.tiling-assistant
    openssl
    gnupg
    git-crypt
    signal-desktop
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vi";
  };

  # Workaround for missing gnome icons
  home.activation.copyDesktopFiles = lib.hm.dag.entryAfter ["installPackages"] ''
   if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
     if [ ! -d "${config.home.homeDirectory}/.local/share/applications" ]; then
       mkdir "${config.home.homeDirectory}/.local/share/applications"
     fi
     if [ -d "${config.home.homeDirectory}/.local/share/applications/nix" ]; then
       rm -rf "${config.home.homeDirectory}/.local/share/applications/nix"
     fi
     ln -sf "${config.home.homeDirectory}/.nix-profile/share/applications" \
       ${config.home.homeDirectory}/.local/share/applications/nix
   fi
 '';


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";

}
