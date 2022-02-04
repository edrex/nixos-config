{ pkgs, lib, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
}