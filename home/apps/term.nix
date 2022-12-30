{pkgs, ...}:  
let
  font = {
    name = "Fira Code";
    size = 10;
  };
in {
  home.sessionVariables = {
    TERMINAL = "${pkgs.foot}/bin/foot";
  };

  home.packages = with pkgs; [
    fzf
    fira-code
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        font = {
          normal.family = font.name;
          size = font.size;
        };
      };
    }; 
    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";

          font = "${font.name}:size=${toString font.size}";
          dpi-aware = "yes";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
};
}