{stdenv, gmp, buildOcaml, camlidl, boost, yojson, ocaml_mysql, mpfr,
 ocaml_batteries, caml_bz2, ocaml_curses,
 fetchFromGitHub}:

buildOcaml rec {
  minimumSupportedOcamlVersion = "4.00";
  name = "ofuzz";
  version = "master-2015-10-22";

  src = fetchFromGitHub {
    owner = "maurer";
    repo = "ofuzz";
    rev = "d740728a831fabafbf300175670f95d8b0948dfd";
    sha256 = "1ece46bba98a1df20e14ec9664a37ed400f095167610c98bffd0c36babd86867";
  };

  buildInputs = [ boost camlidl ocaml_batteries yojson gmp mpfr
                  ocaml_mysql caml_bz2 ocaml_curses ];

  meta = with stdenv.lib; {
    homepage = https://github.com/sangkilc/ofuzz;
    description = "File proccessing utility fuzzer in OCaml";
    maintainers = [ maintainers.maurer ];
  };

  installPhase = ''
    install -D ofuzz $out/bin/ofuzz
  '';
}
