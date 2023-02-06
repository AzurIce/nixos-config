{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ { self, nixpkgs, hyprland, home-manager, ... }: 
  {
    nixosConfigurations = let user = "azurice"; in (
      import ./hosts {
        inherit nixpkgs hyprland home-manager user;
      }
    );
  };
}
