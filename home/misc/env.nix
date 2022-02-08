{ pkgs, config, nix-colors, ... }:


# TODO: break this up to the four winds
{
  home.sessionVariables = {
    # environment variables
    BROWSER = "${pkgs.vivaldi}/bin/vivaldi";
    EDITOR = "${pkgs.neovim}/bin/nvim";

    XKB_DEFAULT_LAYOUT = "us,us";
    XKB_DEFAULT_VARIANT = "colemak,intl";
    XKB_DEFAULT_OPTIONS = "caps:swapescape,grp:alt_space_toggle";

    # wayland
    XDG_SESSION_TYPE = "wayland";
  };

}