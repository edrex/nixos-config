{ config, pkgs, lib, inputs, ... }:
  let 
    interfaces = {
      ap = ["wlan0"];
    };
  in {


  # TODO: networking/wireless/router.nix
  # https://github.com/jgillich/nixos/blob/master/roles/router.nix 
  # https://nixos.wiki/wiki/Networking


  # TODO: networking/wireless/base.nix
   environment.systemPackages = with pkgs; [
     iw
   ];

  # conflicts with hostapd
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.interfaces.wlan0.useDHCP = true;

  # hardware specific, see https://github.com/mirrexagon/espressobin-nix/issues/2#issuecomment-833560329
  networking = {
    useNetworkd = true;
    wireless.enable = false;
    useDHCP = false;
  };
  age.secrets.hostapdConf.file = ../../secrets/whitecanyon/hostapd.conf.age;
  services.hostapd = {
    enable = true;
    interface = "wlan0"; # needed for sysdeps
    #ssid = "whitecanyon";
    #hwMode = "g";
    #channel = 10;
    #wpaPassphrase="";
  };
  systemd.services.hostapd = {
    serviceConfig = {
      ExecStart = lib.mkForce "${pkgs.hostapd}/bin/hostapd ${config.age.secrets.hostapdConf.path}";
      ExecStartPost = [
        "${pkgs.systemd}/lib/systemd/systemd-networkd-wait-online -i wlan0 -o carrier"
        "networkctl reconfigure wlan0" # bring up the bridge
      ];
    };
  };
 

  systemd.network = {
    enable = true;
    netdevs.br0.netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
    networks = {
      eth0 = {
        matchConfig.Name = "eth0";
        networkConfig.LinkLocalAddressing = "ipv6";
        extraConfig = ''
          [Link]
          ActivationPolicy=manual
        '';
      };
      wan = {
        matchConfig.Name = "wan";
        networkConfig = { 
          DHCP = "yes";
          BindCarrier = [ "eth0" ];
          DNSSEC = "yes";
          DNSOverTLS = "yes";
          DNS = [ "8.8.8.8" ];
        };
      };
      wlan0 = {
        matchConfig.Name = "wlan0";
        networkConfig = { 
          Bridge="br0";
        };
        extraConfig = ''
          [Link]
          ActivationPolicy=manual
        '';
      };
 
      lan = {
        matchConfig.Name = "lan*";
        networkConfig = { 
          BindCarrier = [ "eth0" ];
          Bridge="br0";
        };
      };
      # https://wiki.archlinux.org/title/Systemd-networkd#[DHCPServer]
      br0 = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = "192.168.6.1/24";
          DHCPServer = true;
          MulticastDNS = true;
          IPMasquerade=true;
        };
        extraConfig = ''
          [DHCPServer]
          PoolOffset=100
          PoolSize=20
          EmitDNS=yes
          DNS=8.8.8.8
        '';
      };        
    };
  };
  services.fail2ban.enable = true;
  # TODO: let's put as much as possible in a networking module
  # do stuff per-trusted interface
  #  - MulticastDNS = true
  networking.firewall = {
    enable = true;
    allowPing = true;
    trustedInterfaces = [ "br0" ];
    allowedTCPPorts = [
      22    # ssh
      80    # http
      443   # https
      #2222  # git
    ];
    allowedUDPPorts = [ ];
  };
}
