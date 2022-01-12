{ config, pkgs, lib, inputs, ... }: {


  networking = {
    useNetworkd = true;
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
  };
}
