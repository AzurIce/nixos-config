{ nixpkgs, hyprland, home-manager, user, ... }:

{
  laptop-blade = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit user; };
    modules = [
      hyprland.nixosModules.default
      ./laptop-blade
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = import ./laptop-blade/home.nix;
      }
    ];
  };
}

