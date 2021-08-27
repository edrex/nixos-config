# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3
{ config, pkgs, lib, inputs, ... }:
{
  networking.hostName = "pidrive";
  imports =
    [
      ../../profiles/hardware.nix
      ../../profiles/desktop.nix
      ../../mixins/wifi.nix
      # ../../profiles/notebook.nix
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
  boot.kernelParams = ["cma=256M"];

#  nixpkgs.overlays = [
    #(self: super: {
      #firmwareLinuxNonfree = super.firmwareLinuxNonfree.overrideAttrs (old: {
        #version = "2020-12-18";
        #src = pkgs.fetchgit {
          #url =
            #"https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
          #rev = "b79d2396bc630bfd9b4058459d3e82d7c3428599";
          #sha256 = "1rb5b3fzxk5bi6kfqp76q1qszivi0v1kdz1cwj2llp5sd9ns03b5";
        #};
        #outputHash = "1p7vn2hfwca6w69jhw5zq70w44ji8mdnibm1z959aalax6ndy146";
      #});
    #})
  #];

  hardware.enableRedistributableFirmware = true;
  #networking.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  # sound support
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  boot.loader.raspberryPi.firmwareConfig = ''
    dtparam=audio=on
  '';

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  age.secrets.ddclient.file = ../../secrets/pidrive/ddclient.conf.age;
  services.ddclient = {
    enable = true;
    configFile = config.age.secrets.ddclient.path;
  };

  # TODO: mixins/router
  # https://github.com/jgillich/nixos/blob/master/roles/router.nix 
  # https://nixos.wiki/wiki/Networking
  networking.firewall = {
    enable = true;
    allowPing = true;
    trustedInterfaces = [ "wlan0" ];
    allowedTCPPorts = [
      22    # ssh
      80    # http
      443   # https
      #2222  # git
    ];
    allowedUDPPorts = [ ];
  };
  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.5.0/24" ];
    externalInterface = "eth0";
  };
  networking.interfaces = {
    wlan0 = {
      useDHCP = false;
      ipv4.addresses = [{ 
        address = "192.168.5.1";
        prefixLength = 24;
      }];
    };
  };
  services.hostapd = {
    enable = true;
    interface = "wlan0";
    ssid = "mesopotamia";
    wpaPassphrase = "FOOBAR470";
    hwMode = "g";
    channel = 10;
  };

  services.dnsmasq = {
    enable = true;
    servers = [ "8.8.8.8" "8.8.4.4" ];
    extraConfig = ''
      domain=lan
      interface=wlan0
      bind-interfaces
      dhcp-range=192.168.5.10,192.168.5.254,24h
    '';
  };
  services.fail2ban.enable = true;
}
