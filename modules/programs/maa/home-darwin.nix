{ pkgs, user, ... }:

{
  home.file."Library/Application Support/com.loong.maa/config".source = ./maa-config;
}
