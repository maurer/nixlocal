{stdenv, buildOcaml, fetchurl, type_conv, camlp4, opam, ocaml_oasis, js_build_tools }:

buildOcaml rec {
  minimumSupportedOcamlVersion = "4.02";
  name = "sexplib";
  version = "113.33.03";

  src = fetchurl {
    url = "https://github.com/janestreet/sexplib/archive/${version}.tar.gz";
    sha256 = "1klar4qw4s7bj47ig7kxz2m4j1q3c60pfppis4vxrxv15r0kfh22";
  };

  buildInputs = [ opam ocaml_oasis js_build_tools ];

  propagatedBuildInputs = [ type_conv camlp4 ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    homepage = https://ocaml.janestreet.com/;
    description = "Library for serializing OCaml values to and from S-expressions";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
