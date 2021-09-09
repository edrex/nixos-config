{ config, pkgs, lib, ... }: {
  # TODO: mixins/router
  # https://github.com/jgillich/nixos/blob/master/roles/router.nix 
  # https://nixos.wiki/wiki/Networking



  # hardware specific, see https://github.com/mirrexagon/espressobin-nix/issues/2#issuecomment-833560329
  networking.useNetworkd = true;
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
      };
      wan = {
        matchConfig.Name = "wan";
        networkConfig = { 
          DHCP = "yes";
          BindCarrier = [ "eth0" ];
        };
      };
      lan = {
        matchConfig.Name = "lan*";
        networkConfig = { 
          BindCarrier = [ "eth0" ];
          Bridge="br0";
        };
      };
      wlan0 = {
        matchConfig.Name = "wlan0";
        networkConfig = { 
          Bridge="br0";
        };
      };
      # https://wiki.archlinux.org/title/Systemd-networkd#[DHCPServer]
      br0 = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = "192.168.6.1/24";
          DHCPServer = true;
          IPMasquerade=true;
        };
        extraConfig = ''
          [DHCPServer]
          PoolOffset=100
          PoolSize=20
          EmitDNS=yes
          DNS=9.9.9.9
	'';
      };        
    };
  };

  services.fail2ban.enable = true;
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
