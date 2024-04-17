inputs@{ nixpkgs, user, home-manager, nix-darwin, nvim-config, ... }:

nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = inputs;
  modules = [
    ./nix-core.nix
    ./system.nix
    ./apps.nix
    ./host-users.nix
    ./overlays.nix
    home-manager.darwinModules.home-manager
    (let system = "aarch64-darwin"; in {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = inputs // { inherit system; };

      home-manager.users.${user} = import ./home.nix;
    })
  ];
}
