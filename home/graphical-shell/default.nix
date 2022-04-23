{ pkgs, ... }: {
# really close match to my config needs: https://codeberg.org/imMaturana/nixos-config
# todo: rename to "shell" (and module system)
  imports = [ 
    ./sway.nix
    ./displays.nix
    ./notify.nix
  ];


  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
  };

  programs.rofi = {
    enable = true; 
    package = pkgs.rofi-wayland.override {
      plugins = [ pkgs.rofi-emoji ];
    };
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
    foot
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
    rofimoji
    wtype
    lswt
    # themes
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance
    qt5ct
  ];

  services.wlsunset = {
    enable = true;
    # TODO: wire up a location service. Goes along with light/dark UI changes too IMO
    latitude = "45.5";
    longitude = "-122.6";
  }; 


  # TODO: put this in a toolkits include
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome3.gnome-themes-extra;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };


}