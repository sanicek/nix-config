{ config, pkgs, lib, ... }:

{
  home.username = "sanicek";
  home.homeDirectory = "/home/sanicek";

  nixpkgs.config.allowUnfree = true;
  
  # TODO: automatic recursive inclusion
  # example https://github.com/evanjs/nixos_cfg/blob/4bb5b0b84a221b25cf50853c12b9f66f0cad3ea4/config/new-modules/default.nix

  imports =
    [
      ./conf.d/bash.nix
      ./conf.d/git.nix
      ./conf.d/gnome.nix
      ./conf.d/kitty.nix
    ];

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true; # VS Code is synced via github account
  };


  home.packages = with pkgs; [
    google-chrome
    gnomeExtensions.wintile-windows-10-window-tiling-for-gnome
    openssl
    gnupg
    git-crypt
    signal-desktop
    discord
    wget
    input-leap
    dos2unix
    dig
    drawing
  ];
 
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
