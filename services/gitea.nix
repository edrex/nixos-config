{ config, pkgs, lib, ... }:
{
  services.gitea = {
    enable = true;                               # Enable Gitea
    appName = "edrex's code library";     # Give the site a name
    database = {
      type = "postgres";                         # Database type
      passwordFile = "/run/keys/gitea-dbpass";   # Where to find the password
    };
    domain = "lib.pi.pdxhub.org";              # Domain name
    rootUrl = "https://lib.pi.pdxhub.org:9000/";    # Root web URL
    httpPort = 3000;                             # Provided unique port
    settings = {
      mailer = {
        ENABLED = true;
        FROM = "lib@pdxhub.org";
      };
      service = {
        REGISTER_EMAIL_CONFIRM = true;
      };
    };
  };

  services.postgresql = {
    enable = true;
    authentication = ''
      local gitea all ident map=gitea-users
    '';
    identMap =                    # Map the gitea user to postgresql
      ''
        gitea-users gitea gitea
      '';
    ensureDatabases = [ "gitea" ];
    ensureUsers = [
      {
        name = "gitea";
        ensurePermissions = {
          "DATABASE gitea" = "ALL PRIVILEGES";
          "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."lib.pi.pdxhub.org:9000" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass = "http://localhost:3000/";
    };
  };

  security.acme = {
    acceptTerms = true;
    certs = {
      "lib.pi.pdxhub.org".email   = "eric@pdxhub.org";
    };
  };
}
