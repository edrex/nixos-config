{ config, pkgs, lib, ... }:
{

  users.extraUsers.edrex = {
    isNormalUser = true;
    extraGroups = lib.mkDefault [ "wheel" "networkmanager" "audio" "video" "docker" "libvirtd" "plugdev" ];
    shell = pkgs.fish;
    hashedPassword = "$6$99syLpQ4jX2X/J3Q$Xov5YQEdpQa5VU6KsnAVrT7Mj1toF9nbpMCyQK9PMn.8po5ky7a.9Kix/fegVzcwsVl7qxh1yIk4ulTzV3xml.";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7bzUAy5UUu/y2f/7ciDdHE2SgRv0qfFPKIoXoolr1Fifp/WKL4/3IemPrkUEKZmGSt0jWURo/4t35ZTgQVoFIVPxNO16PEo8smPAsWJ+aPkDZXsY+L0SOyZWddFdTB0LEOGp+dSgas5P4efSka9bbv0q0XhiSEgszNDCUoAL1XEmowbI3knQYCLSt/67TRM3/RyK0xlr/6MNzjmz0dOmUX9fM8u/W4UyHxdqrqnJ/nTk4Dy4fJA/4WEjtNXY8ExM4+ehTC/1Xkn+/Ac8+ZYvltbdkHBUG0peJ7J0T1zTdtdbD0itb1XlGHeg2r1x5yj2JHeYwroKbr3K4n5kleTVp" ];
  };

  # services.syncthing = {
  #   enable = lib.mkDefault true;
  #   user = "edrex";
  #   #dataDir = "/home/davidak/.syncthing";
  #   openDefaultPorts = true;
  #   declarative = {
  #     devices = { "nas" = { id = "5WUEWIO-FHLQ6BR-HJPVQBU-7ITVSF2-EB4WZ63-3UYUW6F-FNCK5EC-TWIRWQJ"; introducer = true; }; };
  #     folders = { "info" = { path = "/home/davidak/info"; devices = [ "nas" ]; }; };
  #   };
  # };

  home-manager.users.edrex = { pkgs, ... }: {
    home.packages = with pkgs; [
      # TODO: put this in notetaking.nix
      obsidian
      tig
      bottom
      hledger
      hledger-web
      pulsemixer
      gh
    ];

    services = {
      # gpg-agent = {
      #   enable = true;
      #   enableSshSupport = true;
      # };
      syncthing = {
        enable = true;
        tray.enable = true;
      };
    };

    programs = {
      fish = {
        enable = true;
        shellAliases = {
          g = "${pkgs.git}/bin/git";
          t = "${pkgs.tig}/bin/tig";
          l = "${pkgs.exa}/bin/exa";
          ll = "${pkgs.exa}/bin/exa -l";
          ls = "l";
        };
        
      };
      keychain = {
        enable = true;
        agents = [ "ssh" ];
        # keys = [ "id_ed25519" ];
        # Work around https://github.com/nix-community/home-manager/issues/2256
        enableBashIntegration = false;
      };
      # ssh = {
      #   startAgent = true;
      # };

      git = {
        enable = true;
        userName = "Eric Drechsel";
        userEmail = "eric@pdxhub.org";
        extraConfig = {
          init.defaultBranch = "main";
          push = { default = "current"; };
          pull = { rebase = true; };
        };
      };
      neovim = {
        enable = true;
        # package = neovim-nightly;
        viAlias = true;
        vimAlias = true;
        # withNodeJs = true;

        extraPackages = [
          # himalaya
        ];

        plugins = with pkgs.vimPlugins; [
          vim-airline
          papercolor-theme

          #(pkgs.vimUtils.buildVimPlugin {
          #  name = "himalaya";
          #  src = himalayaSrc + "/vim";
          #})
        ];

        extraConfig = ''
          " papercolor-theme
          " set t_Co=256   " This is may or may not needed.
          set background=light
          colorscheme PaperColor
        '';
      };
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };

      starship =
        {
          enable = true;
          settings = {
            # username = {
            #   format = "[$user](bold blue) ";
            #   disabled = false;
            #   show_always = true;
            # };
            # hostname = {
            #   ssh_only = false;
            #   format = "on [$hostname](bold red) ";
            #   trim_at = ".companyname.com";
            #   disabled = false;
            # };
          };
        };

      bat.enable = true;
      autojump.enable = false;
      zoxide.enable = true;
      fzf.enable = true;
      jq.enable = true;
    };
  };
}
