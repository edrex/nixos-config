{ pkgs, ... }: {

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # https://man.sr.ht/~kennylevinsen/greetd/#how-to-set-xdg_session_typewayland
    #TODO: put this in a reusable script
    extraSessionCommands = ''
      #!/bin/sh

      # Session
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway

      export MOZ_ENABLE_WAYLAND=1
      export NIXOS_OZONE_WL=1
      export CLUTTER_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland-egl
      export ECORE_EVAS_ENGINE=wayland-egl
      export ELM_ENGINE=wayland_egl
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export NO_AT_BRIDGE=1

      #systemd-cat --identifier=sway sway $@
    '';
  };
}
