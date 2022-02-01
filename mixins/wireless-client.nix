{ config, pkgs, lib, ... }: {
   environment.systemPackages = with pkgs; [
     iw
   ];
  networking.wireless.iwd.enable = true;
}
