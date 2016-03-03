let local = import ./default.nix {}; in

{
  bap      = local.pkgs.bap;
  libbap   = local.pkgs.libbap;
  bap_rust = local.pkgs.bap_rust;
  holmes   = local.pkgs.holmes;
  symfuzz  = local.pkgs.symfuzz;
  ofuzz    = local.pkgs.ofuzz;
  vim      = local.pkgs.vim;
  latex    = local.pkgs.latex;
  holmes   = local.pkgs.holmes;
  jakstab  = local.pkgs.jakstab;
  csmith   = local.pkgs.csmith;
}
