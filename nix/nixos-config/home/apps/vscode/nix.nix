{ pkgs, ... }: {

  home.packages = with pkgs; [
    nixpkgs-fmt
    rnix-lsp
    nil
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
  ];

  # settings = {
  #   # "nix.enableLanguageServer" = true;
  #   "nix.formatterPath" = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
  #   "nix.serverPath" = "${rnix-lsp}/bin/rnix-lsp";
  # };
}
