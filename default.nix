{nixpkgs ? import <nixpkgs> { config.allowUnfree = true; }}:

rec {
  pkgs = import ./pkgs.nix {pkgs = nixpkgs;};
  envs = import ./envs.nix {pkgs = pkgs // nixpkgs; lib = nixpkgs.lib;};
}
