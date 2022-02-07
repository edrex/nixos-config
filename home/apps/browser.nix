{ pkgs, ... }: {
   
  home.packages = with pkgs; [
    vivaldi
  ];
  programs = {
    browserpass.enable = true;
  };
}