{ config, pkgs, lib, ... }:

with lib; {
  # options.edrex.sound = {
  #   enable = mkEnableOption "Enable sound";
  # };
  # lib.mkIf (config.hardware.bluetooth.enable) {
  #   services.blueman.enable = true; 
  # } //
  config = lib.mkMerge [
    {
      security.rtkit.enable = true; # ?
      hardware.pulseaudio.enable = mkForce false;
      
      environment.systemPackages = with pkgs; [
        pamixer
        pavucontrol
      ];
      
      programs.dconf.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true; # for old games, wine etc?
        pulse.enable = true;

        # users.extraUsers.edrex.extraGroups = [ "jackaudio" ];
        # jack.enable = true;
      };
    } 
    (lib.mkIf (config.hardware.bluetooth.enable) {
      # https://nixos.wiki/wiki/Bluetooth
      services.blueman.enable = true;
      services.pipewire.media-session.config.bluez-monitor.rules = [{
          # Matches all cards
          matches = [ { "device.name" = "~bluez_card.*"; } ];
          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
              # SBC-XQ is not expected to work on all headset + adapter combinations.
              "bluez5.sbc-xq-support" = true;
            };
          };
        }
        {
          matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    })
  ];
}