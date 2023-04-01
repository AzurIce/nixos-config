{ nixpkgs, hyprland, home-manager, user, nvim-config, ... }:

{
  laptop-blade = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit user; };
    modules = [
      hyprland.nixosModules.default
      {programs.hyprland = {
        enable = true;
        nvidiaPatches = true;
      };}
      ./laptop-blade
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user nvim-config; };
        home-manager.users.${user} = {
          imports = [
            (import ./laptop-blade/home.nix)
          ];
        };
      }
    ];
  };
}

