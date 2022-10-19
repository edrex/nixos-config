{
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixos-hardware.url = github:NixOS/nixos-hardware/master;

    agenix.url = "github:ryantm/agenix"; # consider switching to sops-nix
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url =  "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkSystem = { host, system ? "x86_64-linux", extra-modules ? []}:
      let
        lib = inputs.nixpkgs.lib;
      in
        lib.nixosSystem {
          system = system;
          modules = [
            ./modules
            ({ pkgs, ... }: {
              nix = {
                # readOnlyStore = false;
                settings = {
                  auto-optimise-store = true;
                  sandbox = true;
                  trusted-users = [ "@wheel" ];
                };
                
                extraOptions = ''
                  experimental-features = nix-command flakes
                  # keep-outputs = true
                  # keep-derivations = true
                '';
                gc = {
                  automatic = true;
                  dates = "03:15";
                };
                registry.nixpkgs.flake = inputs.nixpkgs;
              };
              nixpkgs = {
                overlays = with inputs; [
                  inputs.agenix.overlay
                  # https://www.lucacambiaghi.com/nixpkgs/readme.html
                  (
                    final: prev:
                    let
                      system = prev.stdenv.system;
                      # nixpkgs-master = import inputs.nixpkgs-master {
                      #   inherit system;
                      #   config.allowUnfree = true;
                      # };
                    in {
                      # TODO: move this into desktop shell repo
                      pamixer-notify = final.callPackage ./pkgs/pamixer-notify.nix { };
                    }
                  )
                ];
                config = {
                  allowUnfree = true;
                };
              };
            })
            (./. + "/hosts/${host}/configuration.nix")
            (./. + "/home/edrex.nix")
            inputs.home-manager.nixosModules.home-manager # https://rycee.gitlab.io/home-manager/index.html#sec-install-nixos-module
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.edrex = lib.mkMerge [
                ./home
              ];
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
            inputs.agenix.nixosModules.age
          ] ++ extra-modules;
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        chip = mkSystem {
          host = "chip";
          extra-modules = [ inputs.nixos-hardware.nixosModules.dell-xps-13-9360 ];
        };
        pidrive = mkSystem {
          host = "pidrive";
          system = "aarch64-linux";
        };
        whitecanyon = mkSystem {
          host = "whitecanyon";
          system = "aarch64-linux";
        };
        silversurfer = mkSystem {
          host = "silversurfer";
          #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2
        };

      };
    };
}
