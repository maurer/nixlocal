{nixpkgs ? import <nixpkgs> {}}:

let local = import ./default.nix {inherit nixpkgs;}; in

{
  bap      = local.pkgs.bap;
  libbap   = local.pkgs.libbap;
  bap_rust = local.pkgs.bap_rust;
  holmes   = local.pkgs.holmes;
  symfuzz  = local.pkgs.symfuzz;
  ofuzz    = local.pkgs.ofuzz;
  laptop   = local.envs.laptop;
}
