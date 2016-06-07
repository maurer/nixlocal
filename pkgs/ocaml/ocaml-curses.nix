{stdenv, buildOcaml, fetchurl, ncurses}:

buildOcaml rec {
  minimumSupportedOcamlVersion = "4.00";
  name = "curses";
  version = "1.0.3";
  fullName = "ocaml-${name}-${version}";

  src = fetchurl {
    url = "http://ocaml.phauna.org/distfiles/${fullName}.ogunden1.tar.gz";
    sha256 = "0fxya4blx4zcp9hy8gxxm2z7aas7hfvwnjdlj9pmh0s5gijpwsll";
  };

  propagatedBuildInputs = [ ncurses ];

  buildPhase = "make byte && make opt";

  meta = with stdenv.lib; {
    description = "OCaml NCurses Bindings";
    license = licenses.lgpl21;
    maintainers = [ maintainers.maurer ];
  };
}
