{
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs.follows = "nixpkgs-unstable";
    # nixpkgs-hack.url = "path:/home/edrex/o/src/github.com/NixOS/nixpkgs";

    # nixos-hardware.url = github:NixOS/nixos-hardware/master;
    # nixos-hardware.url = "path:/home/eric/src/github.com/NixOS/nixos-hardware";

    # TODO: consider switching to sops-nix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url =  "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    # emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            ({ pkgs, ... }: {
              # cache stuff
              nix = {
                # watch https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/package-management/nix/default.nix
                package = pkgs.master.nixUnstable;
                # readOnlyStore = false;
                settings = {
                  auto-optimise-store = true;
                  sandbox = true;
                };
                
                extraOptions = ''
                  experimental-features = nix-command flakes
                  # keep-outputs = true
                  # keep-derivations = true
                '';
                # TODO: finish going through mudrii/systst (dzone)
                gc = {
                  automatic = true;
                  dates = "03:15";
                };
                registry.nixpkgs.flake = inputs.nixpkgs;
              };

              nixpkgs.overlays = with inputs; [
                inputs.agenix.overlay
                # https://www.lucacambiaghi.com/nixpkgs/readme.html
                (
                  final: prev:
                  let
                    system = prev.stdenv.system;
                    # nixpkgs-stable = if system == "x86_64-darwin" then nixpkgs-stable-darwin else nixos-stable;
                  in {
                    master = nixpkgs-master.legacyPackages.${system};
                    # stable = nixpkgs-stable.legacyPackages.${system};
                    vivaldi = final.callPackage ./pkgs/vivaldi.nix { }; # https://github.com/NixOS/nixpkgs/pull/160234
                    wtype = final.callPackage ./pkgs/wtype.nix { }; # https://github.com/NixOS/nixpkgs/pull/162134
                    lswt = final.callPackage ./pkgs/lswt.nix { }; # https://github.com/NixOS/nixpkgs/pull/158529
                    obsidian = final.callPackage ./pkgs/obsidian.nix { }; # https://github.com/NixOS/nixpkgs/pull/160469
                    pamixer-notify = final.callPackage ./pkgs/pamixer-notify.nix { };
                 }
                )
              ];
              nixpkgs.config = {
                allowUnfree = true;
              };
            })

            (./. + "/hosts/${hostname}/configuration.nix")
            (./. + "/home/edrex.nix")
            inputs.home-manager.nixosModules.home-manager # https://rycee.gitlab.io/home-manager/index.html#sec-install-nixos-module
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.edrex = import ./home;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
            inputs.agenix.nixosModules.age
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        chip = mkSystem inputs.nixpkgs "x86_64-linux" "chip";
        pidrive = mkSystem inputs.nixpkgs "aarch64-linux" "pidrive";
        whitecanyon = mkSystem inputs.nixpkgs "aarch64-linux" "whitecanyon";
        silversurfer = mkSystem inputs.nixpkgs "x86_64-linux" "silversurfer";
        #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2

      };
    };
}
