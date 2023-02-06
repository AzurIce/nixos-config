{ config, pkgs, lib, user, ...}:

{
  users.users.${user}.packages = with pkgs; [
    (callPackage ./package.nix { })
  ];
}
