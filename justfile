set shell := ["nu", "-c"]

# build and switch for mac
mac:
  nix build .#darwinConfigurations.AzurMac.system --extra-experimental-features "nix-command flakes"
  ./result/sw/bin/darwin-rebuild switch --flake .#AzurMac

# set proxy for mac
proxy:
  sudo python3 ~/.config/nixos-config/hosts/AzurMac/scripts/darwin_set_proxy.py
