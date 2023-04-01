{
  inputs = {
    nvim-config = {
      type = "github";
      owner = "AzurIce";
      repo = "nvim";
      flake = false;
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, hyprland, home-manager, nvim-config, ... }: 
  {
    nixosConfigurations = let user = "azurice"; in (
      import ./hosts {
        inherit nixpkgs hyprland home-manager user nvim-config;
      }
    );
  };
}
