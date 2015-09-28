let local = import ./default.nix {}; in

rec {
  bap      = local.pkgs.bap;
  libbap   = local.pkgs.libbap;
  bap_rust = local.pkgs.bap_rust;
  laptop   = local.envs.laptop;
}
