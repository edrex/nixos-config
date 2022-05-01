{ pkgs, ... }: {
  imports =
    [
      ./nix.nix
    ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    # package = pkgs.vscodium;
    # package = pkgs.vscode-insider;
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