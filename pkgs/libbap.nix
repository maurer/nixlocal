{stdenv, ocaml, findlib, camlp4, ocaml_oasis, core_kernel, bap, ncurses,
 fetchFromGitHub,
# XXX These should not be required, and are here to deal with deps bugs
faillib, camlzip, ocamlgraph, bitstring, zarith, uuidm,
fileutils}:

stdenv.mkDerivation rec {
  name = "libbap";
  version = "0";
  src = fetchFromGitHub {
    owner  = "maurer";
    repo   = "libbap";
    rev    = "81bf6f8f5f8543b36137fad0f9c52f4941a46c10";
    sha256 = "043gpcpwr7smj9lp5y5ddfnb2442yr27qr5k2mkadswcv883dvqs";
  };

  buildInputs = [ ocaml findlib camlp4 ocaml_oasis core_kernel bap ncurses
  # XXX These should not be required, and are here to deal with deps bugs
                  faillib camlzip ocamlgraph bitstring
                  zarith uuidm fileutils ];
  preConfigure = "oasis setup";
  doCheck = true;
  meta = with stdenv.lib; {
    description = "C Bindings for BAP";
    license = licenses.mit;
  };
}
