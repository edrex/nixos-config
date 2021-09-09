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

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, deploy-rs, nixos-hardware, home-manager, ... }@inputs:
    let
      mkSystem = pkgs: system: hostname:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            (./. + "/hosts/${hostname}/configuration.nix")
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        pidrive = mkSystem nixpkgs "aarch64-linux" "pidrive";
        silversurfer = mkSystem nixpkgs "x86_64-linux" "silversurfer";
        #TODO: nixos-hardware.nixosModules.apple-macbook-pro-2-2

      };
        deploy.nodes.pidrive.profiles.system = {
            user = "root";
            path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.pidrive;
        };
      homeConfigurations = {
        eric = home-manager.lib.homeManagerConfiguration {
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
