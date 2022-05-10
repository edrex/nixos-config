{ config, pkgs, lib, ... }:

with lib; {
  options.edrex.sound = {
    enable = mkEnableOption "Enable sound";
  };
  config = {

    security.rtkit.enable = true; # ?
    hardware.pulseaudio.enable = mkForce false;

    #TODO: put this in a config key?
    users.extraUsers.edrex.extraGroups = [ "jackaudio" ];
    
    environment.systemPackages = with pkgs; [
      pamixer
    ];
    
    programs.dconf.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true; # for old games, wine etc?
      pulse.enable = true;
      # jack.enable = true;

      media-session.config.bluez-monitor.rules = mkIf (config.hardware.bluetooth.enable) [
        {
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
    };
  };
}