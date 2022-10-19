{ config, pkgs, lib, ... }:

{
  config = {
   # it's a start :)
   environment.systemPackages = with pkgs; [
      kopia
    ];
  };
}