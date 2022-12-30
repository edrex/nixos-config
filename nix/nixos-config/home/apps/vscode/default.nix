{ pkgs, ... }: {
  imports =
    [
      ./nix.nix
    ];

  programs.vscode = {
    enable = true;
    # package = pkgs.vscode;
    # package = pkgs.vscode-fhs;
    # package = pkgs.vscodium;

    # # Snippet to use insiders build
    # package = (pkgs.vscode.override{ isInsiders = true; }).overrideAttrs (oldAttrs: rec {
    #   src = (builtins.fetchTarball {
    #     url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
    #     sha256 = "1nngzi1xdznmrzll9n9yrjiffyajqpw2s03yyd3rfd724m710frx";
    #   });
    #   version = "latest";
    # });
    
    extensions = with pkgs.vscode-extensions; [      
      vscodevim.vim
      jnoortheen.nix-ide
    ];
    # programmatic settings can't coexist with manual ones because https://github.com/microsoft/vscode/issues/15909 😢
    # userSettings = {
    #   "vim.useSystemClipboard" = true;
    #   "vim.highlightedyank.enable" = true;
    #   # "workbench.colorTheme" = "Default Dark+";
    #   "editor.minimap.enabled" = false;
    # };
  };
}