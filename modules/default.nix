{ config, pkgs, ... }:

{
# modular config
# https://github.com/johnae/world/blob/main/modules/host-config.nix
# https://github.com/ckiee/nixfiles/tree/master/hosts/pansear
# getDir: https://github.com/Infinisil/system/blob/master/config/new-modules/default.nix
# http://chriswarbo.net/projects/nixos/useful_hacks.html

  imports = [
    ./av.nix
    ./backup.nix
  ];
}