{ nixpkgs, hyprland, home-manager, nvim-config, ... }:

let user = "azurice"; in {
  laptop-blade = import ./laptop-blade {
      inherit user nixpkgs hyprland home-manager nvim-config;
  };
}

