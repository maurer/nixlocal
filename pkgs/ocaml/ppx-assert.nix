{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_compare, ppx_core, ppx_driver, ppx_here, ppx_sexp_conv, ppx_tools, ppx_type_conv, sexplib}:

buildOcaml rec {
  name = "ppx_assert";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "0kkblwxg4v9c7qq75ndki7b7jvcchrj2dwmri8qvpmz9fbkig0sj";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_compare ppx_core ppx_driver ppx_here ppx_sexp_conv ppx_tools
      ppx_type_conv sexplib ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Assert-like extension nodes that raise useful errors on failure.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
