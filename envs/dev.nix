{ base, gdb, vim, buildEnv, bap }:

buildEnv rec {
  name = "dev";
  ignoreCollisions = true;
  paths = [
    base
    vim
    gdb
    bap
  ];
}
