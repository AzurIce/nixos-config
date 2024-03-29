inputs@{ nixpkgs, nixpkgs-darwin, nix-darwin, nixos-wsl, hyprland, home-manager, nvim-config, nur, ... }:

let user = "azurice"; in {
  nixosConfigurations.laptop-blade = import ./laptop-blade {
    inherit user nixpkgs hyprland home-manager nvim-config nur;
  };
  nixosConfigurations.wsl = import ./wsl {
    inherit user nixpkgs home-manager nvim-config nur nixos-wsl;
  };
  darwinConfigurations.AzurMac = import ./AzurMac {
    inherit user home-manager nvim-config nix-darwin;
    nixpkgs = nixpkgs-darwin;
  };
}

