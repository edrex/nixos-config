{ pkgs, ... }: {
  imports = [ 
    ./sway.nix
    ./displays.nix
  ];


  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    brightnessctl
    wlsunset
    poweralertd
    # TODO: comp fnott
    mako # notification daemon
    foot
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  ];

  services.wlsunset = {
    enable = true;
    latitude = "45.5";
    longitude = "-122.6";
  }; 
}