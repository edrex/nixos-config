{
  outputs = { self, nixpkgs }: {
     nixosConfigurations.pidrive = nixpkgs.lib.nixosSystem {
       system = "aarch64-linux";
       modules = [ ./configuration.nix ];
     };
  };
}
