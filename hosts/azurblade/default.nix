inputs@{ user, nixpkgs, hyprland, home-manager, nvim-config, nur, dotfiles, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = inputs;
  modules = [
    ./configuration.nix
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = inputs;
      home-manager.users.${user} = import ./home.nix;
    }
  ];
}
