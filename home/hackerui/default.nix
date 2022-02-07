{ pkgs, ... }: {
  imports = [ 
    ./sway.nix
    ./kanshi.nix
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
    mako # notification daemon
    foot # Alacritty is the default terminal in the config
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  ];

  services.wlsunset = {
    enable = true;
    latitude = "45.5";
    longitude = "-122.6";
  }; 
}