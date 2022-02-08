{ pkgs, ... }: {
  home.packages = with pkgs;
  [
    kanshi
  ];

  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          { criteria = "eDP-1";
            scale = 2.0;
            position = "0,0";
          }
        ];
      };
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 2.0;
            position = "160,1080";
          }
          {
            criteria = "DP-1";
            scale = 1.0;
            position = "0,0";
          }
        ];
      };
    };
  };
}