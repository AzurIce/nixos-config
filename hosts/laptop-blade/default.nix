{ user, nixpkgs, hyprland, home-manager, nvim-config, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit user hyprland home-manager nvim-config; };
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit user nvim-config; };
      home-manager.users.${user} = import ./home.nix;
    }
  ];
}
