inputs@{ nixpkgs-darwin, ... }:

let user = "azurice"; in {
  nixosConfigurations.laptop-blade = import ./laptop-blade (inputs // {
    inherit user;
  });
  nixosConfigurations.wsl = import ./wsl (inputs // {
    inherit user;
  });
  darwinConfigurations.AzurMac = import ./AzurMac (inputs // {
    inherit user;
    nixpkgs = nixpkgs-darwin;
  });
}

