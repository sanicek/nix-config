{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userEmail = "marian.vencel@gmail.com";
    userName = "Marian Vencel";
  };
}
