{system ? builtins.currentSystem,
 pkgs ? (import <nixpkgs> {}) // (import ../pkgs.nix {}),
 lib ? pkgs.lib
}:

let
  envCall = lib.callPackageWith (pkgs // self // pkgs.haskellPackages);
  self = rec {
    base   = envCall ./base.nix   {};
    laptop = envCall ./laptop.nix {};
    gui    = envCall ./gui.nix    {};
  };
in
self
