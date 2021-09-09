{ config, pkgs, lib, ... }: {

  # Access point
  networking.networkmanager.unmanaged = [ "interface-name:wlan*" ];
  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.6.0/24" ];
    externalInterface = "wan@eth0";
  };
  networking.interfaces = {
    wlan0 = {
      useDHCP = false;
      ipv4.addresses = [{ 
        address = "192.168.6.1";
        prefixLength = 24;
      }];
    };
  };
  services.hostapd = {
    enable = true;
    interface = "wlan0";
    ssid = "whitecanyon";
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
      dhcp-range=192.168.6.10,192.168.6.254,24h
    '';
  };
}
