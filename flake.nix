{
  inputs = {
    devenv.url = "github:cachix/devenv";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, devenv, ... }: 
    flake-parts.lib.mkFlake {
      inherit inputs;
    } {
      systems = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = import ./shell.nix { inherit pkgs inputs;};
      };
      flake = {
        nixosConfigurations = {
          zip = inputs.nixpkgs.lib.nixosSystem {
            modules = [
            ./host
            ./host/zip.nix
            ];
          };
        };
      };
    };
}
