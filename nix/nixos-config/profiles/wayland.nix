{ pkgs, lib, ... }: {
  # way too broad, just for gsettings stuff
  # services.xserver.desktopManager.gnome.enable = true;
 
  environment.systemPackages = with pkgs; [
    wdisplays
    river
    xdg-utils
    wlr-randr
    imv # i guess this should be in a module with basic userspace stuff
    gnome.gnome-software
    gnome.nautilus
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

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


  # flatpak support
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-gtk
    ];
    gtkUsePortal = true;
  };

  # experimental. do i need any/all of these for automount?
  
  services.gvfs.enable = true;
  services.udisks2.enable = true;

}
