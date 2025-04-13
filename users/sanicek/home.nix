{ config, pkgs, lib, ... }:

{
  home.username = "sanicek";
  home.homeDirectory = "/home/sanicek";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.bash.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;

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

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true; # VS Code is synced via github account
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userEmail = "marian.vencel@gmail.com";
    userName = "Marian Vencel";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    google-chrome
    gnomeExtensions.tiling-assistant
    openssl
    gnupg
    git-crypt
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sanicek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vi";
    # XDG_DATA_DIRS = "$HOME/.nix-profile/share:/usr/local/share:/usr/share";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
}
