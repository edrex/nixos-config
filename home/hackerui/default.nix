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
    slurp
    xdg-utils # todo: xdg compat basics import
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
    # TODO: wire up a location service. Goes along with light/dark UI changes too IMO
    latitude = "45.5";
    longitude = "-122.6";
  }; 
}