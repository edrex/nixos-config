{ config, pkgs, lib, nix, inputs, ... }:

{
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  imports =
    [
      inputs.agenix.nixosModules.age
      ../services/ssh.nix
    ];

      nixpkgs.overlays = [
        inputs.agenix.overlay
      ];


  # mount tmpfs on /tmp
  # boot.tmpOnTmpfs = lib.mkDefault true;

  # install basic packages
  environment.systemPackages = with pkgs; [
    htop
    iotop
    iftop
    git
    vim
    wget
    curl
    tcpdump
    # whois
    # mtr
    # siege
    file
    lsof
    inotify-tools
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
  ];

  programs.bash.enableCompletion = true;

  environment.variables = {
    "EDITOR" = "vim";
    "VISUAL" = "vim";
  };

}
