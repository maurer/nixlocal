{system ? builtins.currentSystem,
 pkgs ? import <nixpkgs> {},
 lib ? pkgs.lib
}:

let
  haskell  = pkgs.haskellPackages;
  ocamlP   = baseCall ./ocaml {inherit lib;};
  baseCall = lib.callPackageWith (pkgs // pkgs.lib);
  selfCall = lib.callPackageWith (pkgs // self);
  allCall = lib.callPackageWith (pkgs // ocamlP // haskell // self);
  self = rec {
    vil = baseCall ./vim-lite.nix {};
    bap = ocamlP.bap;
    vim = allCall ./vim.nix {};
    latex = baseCall ./latex.nix {};
    igraph = baseCall ./igraph.nix {};
    bap_rust = selfCall ./bap-rust.nix {};
    holmes = selfCall ./holmes.nix {};
    ocamlPackages = ocamlP;
    aflSymfuzz = baseCall ./afl-symfuzz.nix {};
    jakstab = baseCall ./jakstab.nix {};
    csmith  = baseCall ./csmith.nix {};
    maven-j7 = baseCall ./maven.nix {jdk = pkgs.oraclejdk7;};
    xmonad = pkgs.xmonad-with-packages.override {
      packages = self: [self.xmonad-contrib self.xmonad-extras];
    };
    sandstorm = baseCall ./sandstorm.nix {};
  };
  self_lib = {
    baseCall = baseCall;
    allCall  = allCall;
    selfCall = selfCall;
    camlCall = self.ocamlPackages.camlCall;
  };
in
self // {lib = self_lib;}
