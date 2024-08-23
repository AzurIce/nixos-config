inputs@{ user, nixpkgs, home-manager, ... }:

nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  specialArgs = inputs;
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = inputs // {
        azurmac-nixos = true;
      };
      home-manager.users.${user}= import ./home.nix;

      # Optionally, use home-manager.extraSpecialArgs to pass
      # arguments to home.nix
    }
  ];
}
