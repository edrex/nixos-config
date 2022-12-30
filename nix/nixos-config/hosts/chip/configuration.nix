# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, nixos-hardware, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./keyboards.nix
      ../../profiles/base.nix
      ../../profiles/laptop.nix
      ../../profiles/wayland.nix
      ../../profiles/wireless-client.nix
      ../../profiles/vmhost.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "chip"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # networking.interfaces.wlp58s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  # TODO: printing mixin
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    hplip
  ]; 
  services.avahi.enable = true;
  # Important to resolve .local domains of printers, otherwise you get an error
  # like  "Impossible to connect to XXX.local: Name or service not known"
  services.avahi.nssmdns = true;  # gate settings
  
  sound.enable = true;
  hardware.bluetooth.enable = true;

  # TODO
  hardware.opengl.enable = true;
  services.openssh.enable = true;

  # mount tmpfs on /tmp
  boot.tmpOnTmpfs = lib.mkDefault true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

