# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3
{ config, pkgs, lib, inputs, ... }:
{
  networking.hostName = "pidrive";
  imports =
    [
      ./hardware-configuration.nix
      ../../profiles/base.nix
      ../../profiles/wireless-client.nix
      ../../profiles/hardware.nix
    ];

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;


  # TODO: DRY up interfaces
  systemd.network.networks = {
    eth0 = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "yes";
        DNSSEC = "yes";
        DNSOverTLS = "yes";
        DNS = [ "8.8.8.8" ];
        MulticastDNS = true;
      };
    };
  };

  # sound support
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  age.secrets.ddclient.file = ../../secrets/pidrive/ddclient.conf.age;
  services.ddclient = {
    enable = true;
    configFile = config.age.secrets.ddclient.path;
  };

}
