{ config, pkgs, lib, ... }:

{
  imports =
    [
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
    # wget
    # curl
    # tcpdump
    # whois
    # mtr
    # siege
    # file
    # lsof
    # inotify-tools
    # strace
    # gdb
    # xz
    # lz4
    # zip
    # unzip
    # rsync
    # restic
    # micro
    # xclip
    # tealdeer
    # screen
    # tree
    # dfc
    # pwgen
    # jq
    # yq
    # gitAndTools.gitFull
  ];

  programs.bash.enableCompletion = true;

  # environment.variables = {
  #   "EDITOR" = "micro";
  #   "VISUAL" = "micro";
  # };

  # copy the system configuration into nix-store
  # system.copySystemConfiguration = true;
}
