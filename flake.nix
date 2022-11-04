{
  description = "AzurIce's NixOS Configuration";
  inputs = {
    nur.url = github:nix-community/NUR;
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages
  };
  outputs = inputs @ { self, nixpkgs, nur, hyprland }: {
    nixosConfigurations.blade-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            hyprland.nixosModules.default
            nur.nixosModules.nur
            ./configuration.nix
        ];
    };
  };
}
