
{config, lib, ...}:

# https://nixos.wiki/wiki/Bluetooth
lib.mkIf (config.hardware.bluetooth.enable) {
  services.blueman.enable = true;
}
