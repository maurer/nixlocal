{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_tools, ppx_type_conv, sexplib}:

buildOcaml rec {
  name = "ppx_variants_conv";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "144pfjvwgr5mvykd9plhq4vn0zi6rzrhswql2vg5v7b5l1k2vv5s";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_tools ppx_type_conv sexplib];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Generation of accessor and iteration functions for ocaml variant types.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
