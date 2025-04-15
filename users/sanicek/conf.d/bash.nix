{ config, pkgs, ... }:

{
  home.file.".bash-git-prompt" = {
    source = builtins.fetchGit {
      url = "https://github.com/magicmonty/bash-git-prompt.git";
      #ref = "refs/heads/main";  # You can also use a specific commit SHA or tag
    };
    recursive = true;
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [ -f "${config.home.homeDirectory}/.bash-git-prompt/gitprompt.sh" ]; then
        source ${config.home.homeDirectory}/.bash-git-prompt/gitprompt.sh
        GIT_PROMPT_ONLY_IN_REPO=0
        GIT_PROMPT_THEME=Solarized
        GIT_PROMPT_START_USER="\u@\h:\w"
        GIT_PROMPT_END_USER="\n_LAST_COMMAND_INDICATOR_ \t \$ "
      fi
    '';
  };


  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;
}
