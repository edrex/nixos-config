{ pkgs, ... }: {
# really close match to my config needs: https://codeberg.org/imMaturana/nixos-config
# todo: rename to "shell" (and module system)
  imports = [ 
    ./sway.nix
    ./displays.nix
    ./notify.nix
    ./screenshots.nix
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
    wofi
    rofimoji
    wtype #TODO: eval for removal
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
      package = pkgs.gnome.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };


}
