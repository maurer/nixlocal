{stdenv, buildOcaml, camlidl, zarith, ocaml_batteries, ocamlgraph,
 binutils, fetchFromGitHub}:

buildOcaml rec {
  minimumSupportedOcamlVersion = "4.00";
  name = "bil";
  version = "master-2015-10-22";

  src = fetchFromGitHub {
    owner = "maurer";
    repo  = "libbil";
    rev   = "d99b6bbcbcd0a0379035dfac90c8a069bf2c9617";
    sha256 = "1z1612yynngp63ciflm4c68yp45sbp4kv8ndvvla8jfv0l6gm58j";
  };

  propagatedBuildInputs = [ camlidl zarith ocaml_batteries ocamlgraph binutils ];

  meta = with stdenv.lib; {
    homepage = https://github.com/sangkilc/libbil;
    description = "Stripped down version of BAP 0.8";
    license = licenses.gpl2;
    maintainers = [ maintainers.maurer ];
  };
}
