inputs:

let user = "azurice"; in {
  nixosConfigurations.azurmac-nixos = import ./azurmac-nixos (inputs // {
    inherit user;
  });
  darwinConfigurations.azurmac = import ./azurmac (inputs // {
    inherit user;
  });
}
