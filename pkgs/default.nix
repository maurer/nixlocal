{system ? builtins.currentSystem,
 pkgs ? import <nixpkgs> {},
 lib ? pkgs.lib
}:

let
  haskell  = pkgs.haskellPackages;
  ocamlP   = pkgs.mkOcamlPackages self.ocaml ocamlP;
  baseCall = lib.callPackageWith (pkgs // pkgs.lib);
  selfCall = lib.callPackageWith (pkgs // self);
  camlCall = lib.callPackageWith (pkgs // ocamlP // self);
  allCall = lib.callPackageWith (pkgs // ocamlP // haskell // self);
  self = rec {
    ocaml = baseCall ./ocaml.nix {libX11 = null; xproto = null; useX11 = false;};
    vil = baseCall ./vim-lite.nix {};
    vim = allCall ./vim.nix {};
    latex = baseCall ./latex.nix {};
    bap = camlCall ./bap.nix {};
    libbap = camlCall ./libbap.nix {};
    bap_rust = selfCall ./bap-rust.nix {};
    holmes = selfCall ./holmes.nix {};
  };
in
self
