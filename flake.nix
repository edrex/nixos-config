{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "path:./nixos-hardware"; # TODO: this is temp while I'm working on a branch
  };

  outputs = { self, ... }@inputs: {
     nixosConfigurations = {
       pidrive = inputs.nixpkgs.lib.nixosSystem {
         system = "aarch64-linux";
         modules = [ ./machines/pidrive/configuration.nix ];
       };
       silversurfer = inputs.nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [
           ./machines/silversurfer/configuration.nix
           inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2
         ];
       };
     };
  };
}
#TODO: maybe map machine configs to outputs like https://www.reddit.com/r/NixOS/comments/j4k2zz/does_anyone_use_flakes_to_manage_their_entire/g7jrqcn/?context=3
