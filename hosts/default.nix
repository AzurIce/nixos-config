{ nixpkgs, hyprland, home-manager, nvim-config, nur, nixos-wsl, dotfiles, ... }:

let user = "azurice"; in {
  azurblade = import ./azurblade {
      inherit user nixpkgs hyprland home-manager nvim-config nur dotfiles;
  };
  laptop-blade = import ./laptop-blade {
      inherit user nixpkgs hyprland home-manager nvim-config nur;
  };
  wsl = import ./wsl {
      inherit user nixpkgs home-manager nvim-config nur nixos-wsl;
  };
}

