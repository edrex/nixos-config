{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    #nixos-hardware.url = "path:./nixos-hardware"; # TODO: this is temp while I'm working on a branch

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
            (./. + "/hosts/${hostname}/configuration.nix")
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        pidrive = mkSystem inputs.nixpkgs "aarch64-linux" "pidrive";
        silversurfer = mkSystem inputs.nixpkgs "x86_64-linux" "silversurfer";
        #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2

      };
      homeConfigurations = {
        eric = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { config, pkgs, home, ... }: {
            home.stateVersion = "21.05";
            # home.packages = [ pkgs.hello ];
            # # v This was apparently required
            # programs.home-manager.enable = true;
          };
          system = "x86_64-linux";
          homeDirectory = "/home/eric";
          username = "eric";
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
