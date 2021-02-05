{ config, pkgs, lib, ... }:
{
  imports =
    [
      # /etc/nixos/hardware-configuration.nix
      ../../profiles/hardware.nix
      ../../profiles/common.nix
      # ../../profiles/notebook.nix
      # ../../profiles/desktop.nix
      # ../../profiles/work.nix
      # ../../profiles/communication.nix
      # ../../profiles/development.nix
    ];

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # !!! Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
  # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
  boot.kernelParams = ["cma=32M"];
    
  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };
    
  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];
}
