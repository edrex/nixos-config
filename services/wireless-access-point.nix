{ config, pkgs, lib, ... }:

{
  networking.wireless.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:wlan*" ]
  
}
