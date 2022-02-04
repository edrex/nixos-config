{ pkgs, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
    config = rec {
      modifier = "Mod4";
    };
    extraConfig = ''
      exec_always "systemctl --user restart kanshi.service"
    '';
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    mako # notification daemon
    foot # Alacritty is the default terminal in the config
    dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
  ];
  /*
  - [ ] wrapper is provided by hm?
  - [ ] custom sway config
    - via a string (cuz I already have it)
  - [ ] kanshi or some other display layout automation
  */
}