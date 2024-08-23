inputs@{ user, nixpkgs, home-manager, nix-darwin, ... }:

nix-darwin.lib.darwinSystem rec {
  system = "aarch64-darwin";
  specialArgs = inputs // { inherit system; };
  modules = [
    ./nix-core.nix
    ./system.nix
    ./apps.nix
    ./host-users.nix
    home-manager.darwinModules.home-manager
    (let system = "aarch64-darwin"; in {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = inputs // {
        inherit system;
        azurmac = true;
      };

      home-manager.users.${user} = import ./home.nix;
    })
  ];
}
