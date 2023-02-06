{
fetchurl
, stdenv
, lib
, autoPatchelfHook
, xorg
, gtk3
, pango
, at-spi2-atk
, nss
, libdrm
, alsa-lib
, mesa
, udev
, libappindicator
, imagemagick
, makeDesktopItem
}:


let
  clash-for-windows = {
    pname = "clash-for-windows";
    version = "0.20.12";
    src = fetchurl {
      url = "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.20.12/Clash.for.Windows-0.20.12-x64-linux.tar.gz";
      sha256 = "658d7d5a65b858a71f0aa949e77d36a2871538dec07b5a3608ee628d08016955";
    };
  };
  desktopItem = makeDesktopItem {
    name = "clash-for-windows";
    desktopName = "Clash for Windows";
    comment = "A Windows/macOS/Linux GUI based on Clash and Electron";
    icon = "clash-for-windows";
    exec = "cfw";
    categories = [ "Network" ];
  };
  # icon = "${sources.clash-for-windows-icon.src}[4]";
in
stdenv.mkDerivation rec {
  inherit (clash-for-windows) pname version src;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gtk3
    pango
    at-spi2-atk
    nss
    libdrm
    alsa-lib
    mesa
  ] ++ (with xorg; [
    libXext
    libXcomposite
    libXrandr
    libxshmfence
    libXdamage
  ]);

  runtimeDependencies = [
    libappindicator
    udev
  ];

  installPhase = ''
    mkdir -p "$out/opt"
    cp -r . "$out/opt/clash-for-windows"

    mkdir -p "$out/bin"
    ln -s "$out/opt/clash-for-windows/cfw" "$out/bin/cfw"

    mkdir -p "$out/share/applications"
    install "${desktopItem}/share/applications/"* "$out/share/applications/"

    icon_dir="$out/share/icons/hicolor"
    for s in 16 24 32 48 64 128 256; do
      size="''${s}x''${s}"
      echo "create icon \"$size\""
      mkdir -p "$icon_dir/$size/apps"
    done
  '';

  # ${imagemagick}/bin/convert -resize "$size" "${icon}" "$icon_dir/$size/apps/clash-for-windows.png"

  meta = with lib; {
    homepage = https://github.com/Fndroid/clash_for_windows_pkg;
    description = "A Windows/macOS/Linux GUI based on Clash and Electron";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
