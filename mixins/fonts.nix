{pkgs, ...}: {
    # scp = {
    #   name = "Source Code Pro";
    #   size = 11;

    #   package = pkgs.source-code-pro;
    # };

    # iosevka = {
    #   name = "Iosevka";
    #   size = 13;
    #   package = pkgs.iosevka;
    # };

  fonts.fonts = with pkgs; [
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    iosevka
    hack-font
    source-code-pro
    anonymousPro
  ];
  fonts.fontconfig.defaultFonts.monospace =  [ "Iosevka" ];

}