{ at-spi2-core, atk, cairo, callPackage, clang, cmake, dbus, epoxy, gdk-pixbuf
, glib, gnome, gnome2, gtk3, harfbuzz, lib, libdatrie, libselinux, libsepol
, libthai, libuuid, libxkbcommon, makeWrapper, ninja, pcre, pkg-config, xorg, }:

let
  inherit (lib)
    makeLibraryPath
    makeSearchPath
  ;

  inherit (callPackage ./lib.nix {})
    exportEnvVars
  ;
in
{
  packages = [
    at-spi2-core.dev # atspi-2.pc
    clang
    cmake
    dbus.dev # dbus-1.pc
    epoxy.dev # epoxy.pc
    gtk3.dev
    libdatrie.dev # libdatrie.pc
    libselinux.dev # libselinux.pc
    libsepol.dev # libsepol.pc
    libthai.dev # libthai.pc
    libuuid.dev # mount.pc
    libxkbcommon.dev # xkbcommon.pc
    ninja
    pcre.dev # libpcre.pc
    pkg-config
    xorg.libXdmcp.dev # xdmcp.pc
    xorg.libXtst.out # xtst.pc
  ];

  shellHook =
    ''
      flutter config \
        --enable-linux-desktop \
        > /dev/null
    ''
    + exportEnvVars {
    CPATH = with xorg;
      makeSearchPath "include" [
        libX11.dev # X11/Xlib.h
        xorgproto # X11/X.h
      ];

      LD_LIBRARY_PATH = makeLibraryPath [
        atk.out
        cairo.out
        epoxy.out
        gdk-pixbuf.out
        glib.out
        gtk3.out
        gnome2.pango.out
        harfbuzz.out
      ];
    }
  ;
}
