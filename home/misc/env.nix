{ pkgs, config, nix-colors, ... }:


# TODO: break this up to the four winds
{
  home.sessionVariables = {
    # environment variables
    BROWSER = "${pkgs.vivaldi}/bin/vivaldi";
    EDITOR = "${pkgs.neovim}/bin/nvim";
  };

}