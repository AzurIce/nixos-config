{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };
  outputs = { self, nixpkgs, hyprland, ... }: {
    nixosConfigurations.laptop-blade = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        hyprland.nixosModules.default
        ./hosts/blade-laptop
      ];
    };
  };
}
