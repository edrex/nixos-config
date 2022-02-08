{ pkgs, ... }: {
  imports =
    [
      ./nix.nix
    ];

  home.packages = with pkgs; [
    nixpkgs-fmt
  ];

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jnoortheen.nix-ide
    ];
  };
  # settings = {
  #   # "nix.enableLanguageServer" = true;
  #   "nix.formatterPath" = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
  #   "nix.serverPath" = "${rnix-lsp}/bin/rnix-lsp";
  # };

}