{ config, pkgs, lib, ... }:
{
  nixpkgs.config = {
    # workaround plasma apps install https://github.com/NixOS/nixpkgs/issues/148452
    # Maybe a way to patch just the one package tho?
    allowAliases = false;
  };

  # Enable the X11 windowing system.
  # boo
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  environment.systemPackages = with pkgs; [
  ] ++ builtins.filter lib.isDerivation (builtins.attrValues plasma5Packages.kdeGear)
    ++ builtins.filter lib.isDerivation (builtins.attrValues plasma5Packages.kdeFrameworks)
    ++ builtins.filter lib.isDerivation (builtins.attrValues plasma5Packages.plasma5);
}
