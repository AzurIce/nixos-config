inputs:

let user = "azurice"; in {
  nixosConfigurations.azurmac-nixos = import ./azurmac-nixos (inputs // {
    inherit user;
  });
}
