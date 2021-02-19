{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware.nix
      ./desktop.nix
      ../mixins/wifi.nix
    ];
}
