{ nixpkgs, user, home-manager, nix-darwin, nvim-config, ... }:

nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { inherit user home-manager nvim-config; };
  modules = [
    ./nix-core.nix
    ./system.nix
    ./apps.nix
    ./host-users.nix
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.${user} = import ./home.nix;
    }
  ];
}
