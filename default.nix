{nixpkgs ? import <nixpkgs> {}}:

rec {
  pkgs = import ./pkgs.nix {pkgs = nixpkgs;};
  lib  = pkgs.lib;
  envs = import ./envs.nix {pkgs = nixpkgs // pkgs; lib = nixpkgs.lib;};
}
