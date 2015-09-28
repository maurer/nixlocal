{system ? builtins.currentSystem,
 pkgs ? import <nixpkgs> {},
 lib ? pkgs.lib
}:

let
  haskell  = pkgs.haskellPackages;
  ocaml    = pkgs.ocamlPackages_4_02_1;
  baseCall = lib.callPackageWith (pkgs // pkgs.lib);
  selfCall = lib.callPackageWith self;
  allCall = lib.callPackageWith (pkgs // ocaml // haskell // self);
  self = rec {
    vil = baseCall ./vim-lite.nix {};
    vim = allCall ./vim.nix {};
    latex = baseCall ./latex.nix {};
    bap = allCall ./bap.nix {bitstring = ocaml.bitstring;};
  };
in
self
