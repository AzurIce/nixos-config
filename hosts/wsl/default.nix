{ user, nixpkgs, home-manager, nvim-config, nur, nixos-wsl, ... }:

nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit user home-manager nvim-config; };
  modules = [
    nixos-wsl.nixosModules.wsl
    ./configuration.nix
    nur.nixosModules.nur
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit user nvim-config; };
      home-manager.users.${user} = import ./home.nix;
    }
  ];
}
