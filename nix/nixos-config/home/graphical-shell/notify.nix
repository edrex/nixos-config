{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    # [dunst doesn't display icons · Issue #139 · dunst-project/dunst](https://github.com/dunst-project/dunst/issues/139)
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    # settings = {
    #   global = {
    #     geometry = "300x5-30+50";
    #     transparency = 10;
    #     frame_color = "#eceff1";
    #     font = "Droid Sans 9";
    #     # enable_recursive_icon_lookup = true;
    #     # icon_theme = "hicolor";
    #   };

    #   urgency_normal = {
    #     background = "#37474f";
    #     foreground = "#eceff1";
    #     timeout = 10;
    #   };

    # };
  };

  home.packages = with pkgs; [
    dunst
    libnotify # for notify-send
    pamixer-notify
  ];

  # if sound
  # discussion https://www.reddit.com/r/swaywm/comments/fudm2s/neat_notification_trick_for_your_sway_bash_scripts/
}