{ config, pkgs, ... }:

{
  programs.bash.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
}
