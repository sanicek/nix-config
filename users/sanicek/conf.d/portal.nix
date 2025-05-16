{ pkgs, ... }:

let
  portalPkgs = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];
in
{
  # 1) Install GVfs plus the portal daemons
  home.packages = with pkgs; [
    gvfs             # core virtual-filesystem support 
  ] ++ portalPkgs;

  # 2) Enable and configure the XDG desktop portal for GTK file-chooser dialogs
  xdg.portal = {
    enable = true;
    extraPortals = portalPkgs;
    config = {
      common = {
        # what the GTK file-chooser uses
        default = [ "gtk" ];
      };
      preferred = {
        # fallback for everything else
        default = [ "gtk" ];
        # but route InputCapture to the GNOME portal
        "org.freedesktop.impl.portal.InputCapture" = [ "gnome" ];
      };
    };
  };
}
