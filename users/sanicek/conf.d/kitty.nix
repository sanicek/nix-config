{ config, pkgs, ... }:

{
  programs.kitty.enable = true;
  programs.kitty.font.package = pkgs.vistafonts;
  programs.kitty.font.name = "consolas";
  programs.kitty.font.size = 16;
  programs.kitty.settings = {
    disable_ligatures = "always";
    copy_on_select = true;
    mouse_map = "right press grabbed,ungrabbed paste_from_selection";
    enable_audio_bell = false;
    remember_window_size = false;
    initial_window_width = 640;
    initial_window_height = 400;
    hide_window_decorations = false;
    tab_bar_style = "powerline";
    tab_powerline_style = "slanted";
    editor = "vi";
    update_check_interval = 0;
    shell_integration = "disabled";
    background = "#002b36";
    foreground = "#93a1a1";
    color0 = "#073642";
    color8 = "#586e75";
    color1 = "#dc322f";
    color9 = "#cb4b16";
    color2 = "#859900";
    color10 = "#586e75";
    color3 = "#b58900";
    color11 = "#657b83";
    color4 = "#268bd2";
    color12 = "#839496";
    color5 = "#d33682";
    color13 = "#6c71c4";
    color6 = "#2aa198";
    color14 = "#93a1a1";
    color7 = "#eee8d5";
    color15 = "#fdf6e3";
    selection_background = "#81908f";
    selection_foreground = "#002831";
  };
}
