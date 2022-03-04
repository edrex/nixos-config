{ config, pkgs, lib, nix, inputs, ... }:

{

  imports = [
    ../services/ssh.nix
    ./fonts.nix
  ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;


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
    psmisc
    usbutils
    strace
    gdb
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
    # agenix
    cachix
  ];

  programs.bash.enableCompletion = true;


#TODO: vim editor stuff in module
# vimPlugins.vim-nix

  environment.variables = {
    "EDITOR" = "vim";
    "VISUAL" = "vim";
  };

}
