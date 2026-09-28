{ config, ... }:

{
  programs.bash = {
    enable = true;
    historyFile = "${config.home.homeDirectory}/.bash_history";
    historySize = 5000;
    initExtra = ''
      export GPG_TTY="$(tty)"
      gpg-connect-agent updatestartuptty /bye >/dev/null
    '' + builtins.readFile ../config/bashrc;
  };

  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    keyScheme = "vim";
    interfaceView = "TOP";
  };
}
