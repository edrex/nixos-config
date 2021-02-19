{ config, pkgs, lib, ... }: {
  # temperature / power consumption
  # https://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html
  services.tlp.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;
  # TODO: crib off of https://discourse.nixos.org/t/fan-keeps-spinning-with-a-base-installation-of-nixos/1394/3
}
