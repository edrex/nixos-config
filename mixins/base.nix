{ config, pkgs, lib, nix, inputs, ... }:

{

  imports = [
    ../services/ssh.nix
  ];

  # mount tmpfs on /tmp
  # boot.tmpOnTmpfs = lib.mkDefault true;

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
    agenix
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
