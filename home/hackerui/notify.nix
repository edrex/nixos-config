{ pkgs, ... }: {
  services.dunst = {
    enable = true;
  };

  home.packages = with pkgs; [
    dunst
    libnotify # for notify-send
    pamixer-notify
  ];

  # if sound
  # discussion https://www.reddit.com/r/swaywm/comments/fudm2s/neat_notification_trick_for_your_sway_bash_scripts/
}