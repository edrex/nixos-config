{ config, pkgs, ... }:

{
  imports = [
    ./av.nix
    ./bluetooth.nix
  ];
}