{
  description = "AzurIce's NixOS Configuration";
  inputs = {
    nur.url = github:nix-community/NUR;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages
  };
  outputs = inputs @ { self, nixpkgs, nur }: {
    nixosConfigurations.blade-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            nur.nixosModules.nur
            ./configuration.nix
        ];
    };
  };
}
