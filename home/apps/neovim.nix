{ pkgs, ... }: {
    neovim = {
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
        " papercolor-theme
        " set t_Co=256   " This is may or may not needed.
        set background=light
        colorscheme PaperColor
      '';
    };
}