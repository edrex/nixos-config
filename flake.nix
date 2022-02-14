{
  inputs = {
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs.follows = "nixpkgs-unstable";

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
                # needed for nixos-21.11
                package = pkgs.nixUnstable;
                useSandbox = true;
                autoOptimiseStore = true;
                # readOnlyStore = false;
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

              nixpkgs.overlays = [
                inputs.agenix.overlay
              ];
              nixpkgs.config = {
                allowUnfree = true;
                # till obsidian is updated https://github.com/NixOS/nixpkgs/issues/158956
                permittedInsecurePackages = [
                  "electron-13.6.9"
                ];
              };
            })

            (./. + "/hosts/${hostname}/configuration.nix")
            (./. + "/home/edrex.nix")
            inputs.home-manager.nixosModules.home-manager
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
