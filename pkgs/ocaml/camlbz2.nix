{stdenv, buildOcaml, fetchurl, bzip2}:

buildOcaml rec {
  minimumSupportedOcamlVersion = "4.00";
  name = "bz2";
  version = "0.6.0";
  fullName = "caml${name}-${version}";

  src = fetchurl {
    url = "https://forge.ocamlcore.org/frs/download.php/72/${fullName}.tar.gz";
    sha256 = "123kmqrd8h70dc36gf8fhvlla0y1l0wzhv6m9m5y2j4wd7jb8m41";
  };

  propagatedBuildInputs = [ bzip2 ];

  meta = with stdenv.lib; {
    homepage = https://camlbz2.forge.ocamlcore.org;
    description = "BZ2 Compression Library for OCaml";
    license = licenses.lgpl21;
    maintainers = [ maintainers.maurer ];
  };
}
