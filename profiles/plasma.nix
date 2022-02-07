{ config, pkgs, lib, ... }:
{
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
