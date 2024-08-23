rebuild target:
    sudo nixos-rebuild switch --flake .#{{target}}

# build and switch for mac
mac:
  darwin-rebuild switch --flake .#azurmac
  just proxy

# set proxy for mac
proxy:
  sudo python3 hosts/AzurMac/scripts/darwin_set_proxy.py

