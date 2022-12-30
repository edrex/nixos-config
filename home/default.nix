{ pkgs, ... }: {
  imports =
    [
      ./graphical-shell
      ./devtools
       # ./term
      ./apps/vscode
      ./apps/neovim.nix
      ./apps/emacs
      ./apps/helix.nix
      ./apps/browser.nix
      ./apps/term.nix
      ./apps/comms.nix
    ];

  home.stateVersion = "21.11";

  home.packages = with pkgs; [
    # TODO: put this in edrex/noteshell
    obsidian
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
    };
  };
}

