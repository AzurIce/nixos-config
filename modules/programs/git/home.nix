{ pkgs, user, ... }:

{
  programs.git = {
      enable = true;
      userEmail = "973562770@qq.com";
      userName = "AzurIce";
      extraConfig = {
        http.proxy = "http://127.0.0.1:7890";
        https.proxy = "https://127.0.0.1:7890";
        safe.directory = "*";
      };
  };
}
