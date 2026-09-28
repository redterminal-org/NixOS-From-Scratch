{ lazyvim, ... }:

{
  imports = [
    lazyvim.homeManagerModules.default

    ./home-lazyvim.nix
    ./home-lazyvim-packages.nix
  ];

  programs.bash = {
    enable = true;
    initExtra = builtins.readFile ../config/bashrc;
    historyFile = "/root/.bash_history";
    historySize = 5000;
  };

  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    keyScheme = "vim";
    interfaceView = "TOP";
  };

  home.stateVersion = "26.05";
}
