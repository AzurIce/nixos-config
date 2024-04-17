inputs@{ pkgs, user, system, ... }:

{
  imports =
    if system == "aarch64-darwin" then
        [ ./home-darwin.nix ]
    else
        [];
}
