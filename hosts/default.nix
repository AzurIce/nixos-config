{ nixpkgs, hyprland, home-manager, nvim-config, nur, nixos-wsl, ... }:

let user = "azurice"; in {
  laptop-blade = import ./laptop-blade {
      inherit user nixpkgs hyprland home-manager nvim-config nur;
  };
  wsl = import ./wsl {
      inherit user nixpkgs home-manager nvim-config nur nixos-wsl;
  };
}

