{ pkgs, ... }: {
  imports =
    [
      ./hackerui
      ./vscode.nix
    ];

  home.packages = with pkgs; [
    # TODO: put this in notetaking.nix
    obsidian
    tig
    bottom
    hledger
    hledger-web
    pulsemixer
    gh
  ];

  services = {
    # gpg-agent = {
    #   enable = true;
    #   enableSshSupport = true;
    # };
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };

  programs = {
    fish = {
      enable = true;
      shellAliases = {
        g = "${pkgs.git}/bin/git";
        t = "${pkgs.tig}/bin/tig";
        l = "${pkgs.exa}/bin/exa";
        ll = "${pkgs.exa}/bin/exa -l";
        ls = "l";
      };
      
    };
    keychain = {
      enable = true;
      agents = [ "ssh" ];
      # keys = [ "id_ed25519" ];
      # Work around https://github.com/nix-community/home-manager/issues/2256
      enableBashIntegration = false;
    };
    # ssh = {
    #   startAgent = true;
    # };

    git = {
      enable = true;
      userName = "Eric Drechsel";
      userEmail = "eric@pdxhub.org";
      extraConfig = {
        init.defaultBranch = "main";
        push = { default = "current"; };
        pull = { rebase = true; };
      };
    };
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
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };

    starship =
      {
        enable = true;
        settings = {
          # username = {
          #   format = "[$user](bold blue) ";
          #   disabled = false;
          #   show_always = true;
          # };
          # hostname = {
          #   ssh_only = false;
          #   format = "on [$hostname](bold red) ";
          #   trim_at = ".companyname.com";
          #   disabled = false;
          # };
        };
      };

    bat.enable = true;
    autojump.enable = false;
    zoxide.enable = true;
    fzf.enable = true;
    jq.enable = true;
  };
}

