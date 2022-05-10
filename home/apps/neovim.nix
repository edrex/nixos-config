{ pkgs, ... }: {

  home.packages = with pkgs; [
    # neovide # do i like this?
    ripgrep
    fd
  ];
  programs.neovim = {
    enable = true;
    # package = neovim-nightly;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;

    extraPackages = [
      # himalaya
    ];
    # look at
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-utils.nix
    # https://github.com/m15a/nixpkgs-vim-extra-plugins
    plugins = with pkgs; [
      # maybs
      # https://github.com/liuchengxu/vim-better-default/blob/master/plugin/default.vim

      vimPlugins.vim-airline
      vimPlugins.papercolor-theme
      vimPlugins.telescope-nvim
      vimExtraPlugins.telekasten-nvim
      #(pkgs.vimUtils.buildVimPlugin {
      #  name = "himalaya";
      #  src = himalayaSrc + "/vim";
      #})
    ];
    #TODO: clipboard integration
    extraConfig = ''
      set mouse=a
      set clipboard=unnamedplus
    '';
  };
}
