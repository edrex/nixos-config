{ config, pkgs, lib, ... }: {
  # systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    # wireless = {
    #   # Enables wireless support via wpa_supplicant.
    #   enable = true;  
    #   # userControlled.enable = true;

    # };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  # iwd is faster right?
   environment.systemPackages = with pkgs; [
     iw
   ];
  # networking.wireless.iwd.enable = true;
}
