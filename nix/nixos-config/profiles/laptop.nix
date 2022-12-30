{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware.nix
      ./workstation.nix
    ];

  # temperature / power consumption
  # https://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html
  # TODO(eval): how useful is this?
  services.tlp.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  # TODO: crib off of https://discourse.nixos.org/t/fan-keeps-spinning-with-a-base-installation-of-nixos/1394/3

  # see `man logind.conf`
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=suspend
  '';
  }
