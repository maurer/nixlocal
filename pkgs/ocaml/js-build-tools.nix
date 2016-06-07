{stdenv, buildOcaml, fetchurl, ocaml_oasis, opam}:

buildOcaml rec {
  name = "js-build-tools";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "14z1aqvxdwhfwr7dww4xlai7mj4pgsv05g9dw3rli0swj2y9ngqc";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis opam ];

  dontAddPrefix = true;
  configurePhase = "./configure --prefix $prefix";
  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Jane Street Build Tools";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
