{stdenv, buildOcaml, fetchurl, type_conv, ocaml_oasis, js_build_tools, opam}:

buildOcaml rec {
  name = "variantslib";
  version = "113.33.03";

  minimumSupportedOcamlVersion = "4.00";

  src = fetchurl {
    url = "https://github.com/janestreet/variantslib/archive/${version}.tar.gz";
    sha256 = "1hv0f75msrryxsl6wfnbmhc0n8kf7qxs5f82ry3b8ldb44s3wigp";
  };

  buildInputs = [ ocaml_oasis js_build_tools opam ];

  propagatedBuildInputs = [ type_conv ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    homepage = https://github.com/janestreet/variantslib;
    description = "OCaml variants as first class values";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
