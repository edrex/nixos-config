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
         modules = [ ./machines/pidrive/configuration.nix ];
       };
     };
  };
}
