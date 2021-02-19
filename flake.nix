{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: {
     nixosConfigurations = {
       pidrive = nixpkgs.lib.nixosSystem {
         system = "aarch64-linux";
         modules = [ ./machines/pidrive/configuration.nix ];
       };
       silversurfer = nixpkgs.lib.nixosSystem {
         system = "aarch64-linux";
         modules = [ ./machines/silversurfer/configuration.nix ];
       };
     };
  };
}
#TODO: maybe map machine configs to outputs like https://www.reddit.com/r/NixOS/comments/j4k2zz/does_anyone_use_flakes_to_manage_their_entire/g7jrqcn/?context=3
