{pkgs, ...}: {
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  fonts.fontconfig.defaultFonts.monospace =  "FiraCode";

}