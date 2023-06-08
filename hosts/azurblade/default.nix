{ user, nixpkgs, hyprland, home-manager, nvim-config, nur, dotfiles, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit user hyprland home-manager nvim-config dotfiles; };
  modules = [
    ./configuration.nix
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit user nvim-config dotfiles; };
      home-manager.users.${user} = import ./home.nix;
    }
  ];
}
