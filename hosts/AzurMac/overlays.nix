inputs@{ neovim-nightly-overlay, joshuto, ... }:

{
  nixpkgs.overlays = [
    neovim-nightly-overlay.overlay
    joshuto.overlays.default
  ];
}
