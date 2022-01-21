{ config, pkgs, lib, ... }:

{
  # boot splash instead of log messages
  # boot.plymouth.enable = true;
  # programs.ssh.startAgent = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      foot # Alacritty is the default terminal in the config
      wofi # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
  };

  environment.systemPackages = with pkgs; [
    qutebrowser
    foot
    firefox
  ];
}
