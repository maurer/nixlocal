{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_tools, ppx_type_conv, sexplib}:

buildOcaml rec {
  name = "ppx_sexp_conv";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "02c1sfxv7kqfrvw3nr2g3a9yw0ca3w176ma47rmxsnfcq4n9cshy";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_tools ppx_type_conv sexplib];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "A ppx rewriter that defines an extension node whose value is its source position.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
