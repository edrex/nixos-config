{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "path:/home/eric/src/github.com/NixOS/nixpkgs";

    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    # nixos-hardware.url = "path:/home/eric/src/github.com/NixOS/nixos-hardware";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url =  "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            ({ pkgs, ... }: {
              # cache stuff
              nix.gc.automatic = true;
              nix.gc.dates = "03:15";

              # flake support
              nix.extraOptions = "experimental-features = nix-command flakes ca-references";
              nix.package = pkgs.nixUnstable;
              nix.registry.nixpkgs.flake = inputs.nixpkgs;

              nixpkgs.overlays = [
                inputs.agenix.overlay
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            })

            (./. + "/hosts/${hostname}/configuration.nix")
            (./. + "/users/edrex.nix")
            inputs.agenix.nixosModules.age
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        pidrive = mkSystem inputs.nixpkgs "aarch64-linux" "pidrive";
        whitecanyon = mkSystem inputs.nixpkgs "aarch64-linux" "whitecanyon";
        silversurfer = mkSystem inputs.nixpkgs "x86_64-linux" "silversurfer";
        #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2

      };
    };
}
