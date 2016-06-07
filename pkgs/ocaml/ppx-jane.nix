{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, ppx_assert, opam,
 ppx_bench, ppx_bin_prot, ppx_compare, ppx_custom_printf, ppx_driver,
 ppx_enumerate, ppx_expect, ppx_fail, ppx_fields_conv, ppx_here,
 ppx_inline_test, ppx_let, ppx_pipebang, ppx_sexp_conv, ppx_sexp_message,
 ppx_sexp_value, ppx_typerep_conv, ppx_variants_conv}:

buildOcaml rec {
  name = "ppx_jane";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "08k81d59h5m09a66wjxm39p0n1shk2j6clykr9imigbhfh7jq22x";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_assert ppx_bench ppx_bin_prot ppx_compare ppx_custom_printf
      ppx_driver ppx_enumerate ppx_expect ppx_fail ppx_fields_conv
      ppx_here ppx_inline_test ppx_let ppx_pipebang ppx_sexp_conv
      ppx_sexp_message ppx_sexp_value ppx_typerep_conv ppx_variants_conv ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "ppx_jane is a ppx_driver including all standard ppx rewriters.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
