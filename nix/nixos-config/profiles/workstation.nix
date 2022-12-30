{config, pkgs, ...}: {
  ## print/scan
  hardware.sane.enable = true;
  users.users.edrex.extraGroups = [ "scanner" "lp" ];
  hardware.sane.extraBackends = [
    pkgs.sane-airscan
    pkgs.hplipWithPlugin
  ];

  environment.systemPackages = with pkgs; [
    gimp-with-plugins
    simple-scan
    gscan2pdf
    skanlite
    ];



}