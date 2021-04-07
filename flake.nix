{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "path:./nixos-hardware"; # TODO: this is temp while I'm working on a branch

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs:
    let
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [(./. + "/hosts/${hostname}/configuration.nix")];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        pidrive = mkSystem inputs.nixpkgs "aarch64-linux" "pidrive";
        silversurfer = mkSystem inputs.nixpkgs "x86_64-linux" "silversurfer";
        #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2
      };
    };
}
#TODO: maybe map machine configs to outputs like https://www.reddit.com/r/NixOS/comments/j4k2zz/does_anyone_use_flakes_to_manage_their_entire/g7jrqcn/?context=3
