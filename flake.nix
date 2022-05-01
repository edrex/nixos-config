{
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix.url = "github:nixos/nix";
    # nix.url = "github:flox/nix/lock_installable";
    # nix.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    # nixpkgs-local.url = "path:/home/edrex/src/github.com/NixOS/nixpkgs";
    nixpkgs.follows = "nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    # nixos-hardware.url = "path:/home/eric/src/github.com/NixOS/nixos-hardware";

    # TODO: consider switching to sops-nix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url =  "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vim-extra-plugins = {
      url = "github:m15a/nixpkgs-vim-extra-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nixvim = {
      url = "github:immaturana/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    # emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
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
                package = pkgs.nixUnstable;
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
                  inputs.vim-extra-plugins.overlay
                  # https://www.lucacambiaghi.com/nixpkgs/readme.html
                  (
                    final: prev:
                    let
                      system = prev.stdenv.system;
                      nixpkgs-master = import inputs.nixpkgs-master {
                        inherit system;
                        config.allowUnfree = true;
                      };
                      # nixpkgs-stable = if system == "x86_64-darwin" then nixpkgs-stable-darwin else nixos-stable;
                    in {
                      stable = nixpkgs-stable.legacyPackages.${system};
                      # nixUnstable = nixpkgs-master.nixUnstable;
                      vscode-insider = (prev.vscode.override {isInsiders = true;}).overrideAttrs (oldAttrs: rec {
                        src = (builtins.fetchTarball {
                          url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
                          sha256 = "1a9xf0kkvhgfi8aj92wywsnyvrpclk2ffbkq1w3fzd733n8sscj8";
                        });
                        version = "latest";
                      });
                      nixUnstable = inputs.nix.defaultPackage.${system};
                      # vivaldi = final.callPackage ./pkgs/vivaldi.nix { }; # https://github.com/NixOS/nixpkgs/pull/160234
                      wtype = final.callPackage ./pkgs/wtype.nix { }; # https://github.com/NixOS/nixpkgs/pull/162134
                      lswt = final.callPackage ./pkgs/lswt.nix { }; # https://github.com/NixOS/nixpkgs/pull/158529
                      obsidian = final.callPackage ./pkgs/obsidian.nix { };
                      lunarvim = final.callPackage ./pkgs/lunarvim.nix { };
                      # electron crashes with wayland:
                      # https://github.com/electron/electron/issues/32436 (waiting on )
                      # https://github.com/electron/electron/issues/32487
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
                inputs.nixvim.homeManagerModules.nixvim
                inputs.nix-doom-emacs.hmModule
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
