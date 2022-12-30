{ pkgs, ... }: {

  home.packages = with pkgs; [
    # neovide # do i like this?
    ripgrep
    fd
    fzf # for wiki
  ];
  programs.neovim = let

  in {
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
      # {
      #   plugin = pkgs.vimUtils.buildVimPlugin {
      #     name = "wiki.vim";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "lervag";
      #       repo = "wiki.vim";
      #       rev = "7d665b8fa0b20eb29b5dfcae976a2ae66853b6b8";
      #       sha256 = "sha256-087ZTcMdHQvv1PIsiRKL7K421sK32xl0+Bs+/MwKOCc=";
      #     };
      #   };
      #   config = ''
      #     let g:wiki_root = '~/wiki'
      #     let g:wiki_filetypes = ['md']
      #     let g:wiki_index_name = 'Start'
      #   '';
      # }
      # maybs
      # https://github.com/liuchengxu/vim-better-default/blob/master/plugin/default.vim

      # vimPlugins.zk
      vimPlugins.vim-airline
      vimPlugins.papercolor-theme
      vimPlugins.telescope-nvim
      vimPlugins.ctrlp
      # vimExtraPlugins.telekasten-nvim
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
