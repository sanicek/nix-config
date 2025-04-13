{ config, pkgs, ... }:

{
  dconf = {
    enable = true;
    settings= {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-uri = "file://${config.home.homeDirectory}/Pictures/wallpaper.jpg";
        picture-uri-dark = "file://${config.home.homeDirectory}/Pictures/wallpaper.jpg";
        picture-options = "fit";
      };
    };

  };
}
