{ base, gui, pianobar, latex, mendeley, gdb, vim, buildEnv, bap }:

buildEnv rec {
  name = "laptop";
  ignoreCollisions = true;
  paths = [
    base
    gui
    vim
    latex
    mendeley
    gdb
    bap
  ];
}
