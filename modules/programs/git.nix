inputs@{ pkgs, user, azurmac, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "973562770@qq.com";
    userName = "AzurIce";
    extraConfig = {
      http.proxy = "http://127.0.0.1:7890";
      https.proxy = "https://127.0.0.1:7890";
      safe.directory = "*";
      credential = {
        credentialStore = if azurmac then
          "keychain"
        else
          "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
    };

    delta.enable = true;
  };
}
