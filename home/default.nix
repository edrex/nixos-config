{ pkgs, ... }: {
  imports =
    [
      ./graphical-shell
       # ./term
      ./apps/vscode
      ./apps/neovim.nix
      ./apps/emacs
      ./apps/helix.nix
      ./apps/browser.nix
      ./apps/term.nix
      ./apps/comms.nix
    ];
/*
- [x] sway Tap to click
- [ ] wpa sup?
- [ ] term
    - font?
- [ ] 
*/

  home.stateVersion = "21.11";
  # workaround https://github.com/nix-community/home-manager/issues/3342
  manual.manpages.enable = false; 

  home.packages = with pkgs; [
    # TODO: put this in edrex/noteshell
    obsidian
    tig
    bottom
    # hledger
    # hledger-web
    pulsemixer
    gh
    gopass
    fishPlugins.foreign-env # fenv command
    gnupg
  ];

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
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
        e = "emacsclient -nc";
      };
      
    };

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
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    bat.enable = true;
    autojump.enable = false;
    zoxide.enable = true;
    fzf.enable = true;
    jq.enable = true;
  };
}

