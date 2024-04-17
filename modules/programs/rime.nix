inputs@{ pkgs, user, dotfiles, ... }:

{
  home.file."Library/Rime/default.custom.yaml".source = "${dotfiles}/rime/default.custom.yaml";
  home.file."Library/Rime/luna_pinyin.custom.yaml".source = "${dotfiles}/rime/luna_pinyin.custom.yaml";
}
