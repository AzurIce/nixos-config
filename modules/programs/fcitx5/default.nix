{ config, lib, pkgs, ... }:

{
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-rime
    fcitx5-chinese-addons
  ];
  i18n.inputMethod.fcitx5.enableRimeData = true; # 需要，否则会出现输入字符后有下划线标识但除了一些符号（如=#等）无候选框，按空格后也只是输入了英文的问题。

  environment.systemPackages = with pkgs; [
    fcitx5-gtk
    fcitx5-lua
    fcitx5-configtool
  ];
}
