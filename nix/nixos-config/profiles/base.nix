{ config, pkgs, lib, nix, inputs, ... }:
{
  networking = {
    #useNetworkd = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  # systemd-networkd-wait-online.service fails after a timeout if enabled, similar to
  # https://github.com/NixOS/nixpkgs/issues/30904
  # systemd.network = {
  #   enable = true;
  # };

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = lib.mkDefault false;
  };

  users.extraUsers.root.openssh.authorizedKeys.keys = lib.mkDefault [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnE3wt2x/iY57AqQWmMThUhsLq2KuYdQHsv/Twh7fadlGXGA49K9Ksu6PLJ7B8e10g4izjFIk4j9tMMZxxeOjBYcqRPLPdQLjZrxWePQ0ZYcMThaNE78YygbOJcRsSomOtu2+9XV4nkatBoFZ+YINH8L9lpOFT/8N0NSq4whdant+gr/Dd8nOpKd3ceRGwOx7FEwKeZjIM5+nrOxjZnwGTAExrYuZIsBdysc7xoCa83tRw1BO6zJLMNKugr5RR5f76fec3p7BdMgB7D3tnOp2jFBOcEG2Tw7GNO+D/2rglKDkDmTCQN9lJys8lfP4G+cGoM+uIP+OypQkuZ4xqJ7dKdSCOQ1UCuOubXd2uwqJsTrwo01lNJKkQWR66tfBqzVLxyNWUkgdGAxl0s4QSJQj8fwv7754WWf5NYKSp4TO4ZOnUtkchjwxG1jMWndMiiPxOfOrP1J1YQ4Rw1sB1/TKsMbteyUk9N/xOp2WazQW7uARpDJbbsLjhH0IA3UCSmZWnXSjSDPAqk49XsQZ52K1Po6xOhvLA7SCDWaSrx7hNUbrEPkyfi4dIMF+G3j42+wjHE7PxN7yYIlJW1TTWxc2mVvPOT6emFRCrEFgOgwXVwMqH3rt1tKwf6z5Psy0hoZmK0Rt7TtdLkDzPrSCris1wOlzCR0Bm5mQ01DDVkrq7ow== edrex@chip" ];


  fonts.fonts = with pkgs; [
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    iosevka
    hack-font
    source-code-pro
    anonymousPro
  ];
  fonts.fontconfig.defaultFonts.monospace =  [ "Iosevka" ];

  # Select internationalisation properties.
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # install basic packages
  environment.systemPackages = with pkgs; [
    htop
    iotop
    iftop
    git
    neovim
    wget
    curl
    tcpdump
    dig
    parted
    # whois
    # mtr
    # siege
    file
    lsof
    inotify-tools
  # TODO: put this stuff behind an edrex.use.debugging flag
    psmisc
    usbutils
    strace
    gdb
    # dev:c
    cmake
    ## Infosec
      nmap
    # nix x dev
    nixpkgs-review
    nix-tree
    # xz
    # lz4
    # zip
    # unzip
    rsync
    # restic
    # xclip
    tealdeer
    tmux
    # screen
    # tree
    # dfc
    # pwgen
    jq
    # yq
    # gitAndTools.gitFull
    # nix dev
    agenix
    cachix
    diffoscope
  ];
}
