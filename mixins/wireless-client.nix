{ config, pkgs, lib, ... }: {
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
    # userControlled.enable = true;
  };
  

  # TODO: iwd is faster right?
  #  environment.systemPackages = with pkgs; [
  #    iw
  #  ];
  # networking.wireless.iwd.enable = true;
}
