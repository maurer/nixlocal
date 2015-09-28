{ git, vil, rxvt_unicode, gnumake, htop, which, file, unzip, buildEnv }:

buildEnv rec {
  name = "base";
  ignoreCollisions = true;
  paths = [
    git
    vil
    rxvt_unicode.terminfo
    gnumake
    htop
    which
    file
    unzip
  ];
}
