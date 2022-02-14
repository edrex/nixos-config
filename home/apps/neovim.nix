{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    # package = neovim-nightly;
    viAlias = true;
    vimAlias = true;
    # withNodeJs = true;

    extraPackages = [
      # himalaya
    ];

    plugins = with pkgs.vimPlugins; [
      vim-airline
      papercolor-theme

      #(pkgs.vimUtils.buildVimPlugin {
      #  name = "himalaya";
      #  src = himalayaSrc + "/vim";
      #})
    ];

    extraConfig = ''
      set mouse=a
    '';
  };
}
