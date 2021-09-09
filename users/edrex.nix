{ config, pkgs, lib, ... }:
{

  users.extraUsers.edrex = {
    isNormalUser = true;
    extraGroups = lib.mkDefault [ "wheel" "networkmanager" "audio" "video" "docker" "libvirtd" "plugdev" ];
  };

  # services.syncthing = {
  #   enable = lib.mkDefault true;
  #   user = "davidak";
  #   #dataDir = "/home/davidak/.syncthing";
  #   openDefaultPorts = true;
  #   declarative = {
  #     devices = { "nas" = { id = "5WUEWIO-FHLQ6BR-HJPVQBU-7ITVSF2-EB4WZ63-3UYUW6F-FNCK5EC-TWIRWQJ"; introducer = true; }; };
  #     folders = { "info" = { path = "/home/davidak/info"; devices = [ "nas" ]; }; };
  #   };
  # };

  # home-manager.useUserPackages = true;
  # home-manager.useGlobalPkgs = true;

  home-manager.users.edrex = { pkgs, ... }: {
  #   #home.packages = with pkgs; [ httpie ];

    programs = {
  #     bash = {
  #       enable = true;
  #       historyControl = [ "ignoredups" "ignorespace" ];
  #     };

  #     ssh = {
  #       enable = true;
  #       serverAliveInterval = 60;
  #     };

      git = {
        enable = true;
        userName = "Eric Drechsel";
        userEmail = "eric@pdxhub.org";
  #       extraConfig = {
  #         push = { default = "current"; };
  #         pull = { rebase = true; };
  #       };
      };
    };

  #   # manuals not needed
  #   manual.html.enable = false;
  #   manual.json.enable = false;
  #   manual.manpages.enable = false;
  };
}
