{stdenv, buildOcaml, yojson, ocaml_batteries, ounit, fetchFromGitHub}:

buildOcaml rec {
  minimumSupportedOcamlVersion = "4.02";
  name = "libinput";
  version = "master-2015-10-22";

  src = fetchFromGitHub {
    owner = "sangkilc";
    repo  = "libinput";
    rev = "02b3d156e616b45b6c9fe316acb252aa85612cca";
    sha256 = "1vlbwx5y2d5bm382v02wj0wcvxf6pg46m56lj51p8w1zgcddjrmk";
  };

  propagatedBuildInputs = [ ocaml_batteries yojson ounit ];

  doCheck = true;
  checkPhase = "make unittest";

  meta = with stdenv.lib; {
    homepage = https://github.com/sangkilc/libbil;
    description = "Program Input Representation in OCaml";
    maintainers = [ maintainers.maurer ];
  };
}
