{stdenv, ocaml, findlib, camlidl, bil, ocaml_libinput, fetchurl, boost, camlp4,
 makeWrapper, fetchFromGitHub}:

let
  pin = fetchurl {
    url = "http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-67254-gcc.4.4.7-linux.tar.gz";
    sha256 = "01khqw32cg6z9li6f07ljpm7n4azdbk3w2jnfh62ldiz73nwz6a4";
  };
  symfuzz = fetchFromGitHub {
    owner = "maurer";
    repo = "symfuzz";
    rev = "94e793336efc38c5163de6bf7295014f904b9b1a";
    sha256 = "0m0r1r6p2lql2d608zd5drfahpaxkhnzdmbnlb1f85hwjqv3kfqg";
  };
in
stdenv.mkDerivation rec {
  name = "symfuzz";
  version = "0";
  srcs = [symfuzz pin];
  sourceRoot = symfuzz.name;

  postUnpack = ''
    ln -sr ./pin* $sourceRoot/pin
  '';

  installPhase = ''
    export AFUZZ_PATH=$out/share/symfuzz
    mkdir -p $out/bin
    mkdir -p $out/share
    cp -aL . $AFUZZ_PATH
    makeWrapper $AFUZZ_PATH/src/symfuzz $out/bin/symfuzz --set AFUZZ_PATH $AFUZZ_PATH
    makeWrapper $AFUZZ_PATH/src/depreader $out/bin/depreader --set AFUZZ_PATH $AFUZZ_PATH
  '';

  buildInputs = [ocaml findlib camlidl ocaml_libinput bil boost camlp4
                 makeWrapper];
  meta = with stdenv.lib; {
    description = "TODO fill in";
    license = licenses.mit;
  };
}
