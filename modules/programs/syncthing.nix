{ config, pkgs, lib, user, ...}:

{
  # syncthingtray
  # environment.systemPackages = with pkgs; [ syncthingtray ];
  users.users.${user}.packages = with pkgs; [ syncthingtray ];

  # syncthing
  services.syncthing = {
      enable = true;
      user = "azurice";
      dataDir = "/home/azurice/Documents";
      configDir = "/home/azurice/Documents/.config/syncthing";
      folders = {
          "Notes" = {
              id = "Notes";
              path = "/home/azurice/File/__Syncthing__/Notes";
              devices = [ "DESKTOP-AORUS" "DESKTOP"];
          };
          "Pics" = {
              id = "Pics";
              path = "/home/azurice/File/__Syncthing__/Pics";
              devices = [ "DESKTOP-AORUS" "DESKTOP"];
          };
      };
      devices = {
          DESKTOP-AORUS = {
              id = "PFCP7N4-5QOYSNB-GQ5LUV3-W7BPLAZ-5AXLAMG-NHRH2OK-YPTX4LU-EFIRAAU";
          };
          DESKTOP = {
              id = "D2KODQT-PE2DR2U-EOZPXTY-NF7VPYK-UM4GSC3-LC3XHYP-TBR5ZNQ-G3HDFA2";
          };
      };
  };
}
