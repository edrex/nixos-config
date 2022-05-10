{ pkgs, config, nix-colors, ... }:


# TODO: break this up to the four winds
{
  home.sessionVariables = {
    # environment variables
    EDITOR = "${pkgs.neovim}/bin/nvim";
  };

}