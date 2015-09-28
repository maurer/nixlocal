let local = import ./default.nix {}; in

rec {
  bap    = local.pkgs.bap;
  laptop = local.envs.laptop;
}
