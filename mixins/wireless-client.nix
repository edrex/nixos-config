{ config, pkgs, lib, ... }: {
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

  # TODO: iwd is faster right?
  #  environment.systemPackages = with pkgs; [
  #    iw
  #  ];
  # networking.wireless.iwd.enable = true;
}
