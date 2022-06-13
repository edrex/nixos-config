{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.keyd;
in

{
  meta = {
    maintainers = [ maintainers.cidkid ];
  };

  options = {
    services.keyd = {
      enable = mkEnableOption "keyd daemon for remapping keys";

      package = mkPackageOption pkgs "keyd" { };

      configuration = mkOption {
        type = types.attrsOf (types.lines);

        default = {};

        description = ''
          Attribute set of keyd configuration strings. See https://github.com/rvaiya/keyd/blob/master/docs/keyd.scdoc
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    users.groups.keyd = { };
    environment = {
      etc = lib.attrsets.mapAttrs' (name: tcfg: nameValuePair "keyd/${name}.conf" { text = tcfg; }) cfg.configuration;
      systemPackages = [ cfg.package ];
    };

    systemd.services.keyd = {
      description = "key remapping daemon";
      wantedBy = [ "sysinit.target" ];
      requires = [ "local-fs.target" ];
      after = [ "local-fs.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/keyd";
      };
    };
  };
}