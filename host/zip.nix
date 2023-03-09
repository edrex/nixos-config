{ config, pkgs, ... }:

{
  networking.hostName = "zip";
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = true;
  system.stateVersion = "22.11"; # Did you read the comment?

}

