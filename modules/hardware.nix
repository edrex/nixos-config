{ config, pkgs, lib, nixos-hardware, ... }:

with lib; {
  options.hardware.module = mkOption {
         default = "";
         type = with types; uniq string;
         description = ''
           nixos-hardware module to import
           see https://github.com/NixOS/nixos-hardware/blob/master/flake.nix for list
         '';
       };

  config = {
    imports = [ nixos-hardware.nixosModules.dell-xps-13-9360 ]
            
