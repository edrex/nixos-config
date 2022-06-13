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

      package = mkOption {
        type = types.package;
        default = pkgs.keyd;
        defaultText = literalExpression "pkgs.keyd";
        description = ''
          KeyD Package to use.
        '';
      };

      configuration = mkOption {
        type = types.attrsOf (types.submodule ({ config, options, ... }: {
          options = {
            text = mkOption {
              type = types.lines;
              default = null;
            };
          };
        }));

        default = {};

        description = ''
          What the filename should be for configuration files for keyd (Multiple are allowed in keyd).
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    users.groups.keyd = {
      gid = 994;
    };
    environment = {
      etc = lib.attrsets.mapAttrs' (name: tcfg: nameValuePair "keyd/${name}.conf" { text = tcfg.text; }) cfg.configuration;
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