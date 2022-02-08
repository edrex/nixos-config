{ pkgs, ... }: {
  imports =
    [
      ./nix.nix
    ];

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jnoortheen.nix-ide
    ];
    userSettings = {
      "vim.useSystemClipboard" = true;
      "vim.highlightedyank.enable" = true;
      # "workbench.colorTheme" = "Default Dark+";
      "editor.minimap.enabled" = false;
    };
  };
}