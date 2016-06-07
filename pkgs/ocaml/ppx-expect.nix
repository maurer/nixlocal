{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_assert, ppx_compare, ppx_core, ppx_custom_printf, ppx_driver,
 ppx_fields_conv, ppx_here, ppx_inline_test, ppx_sexp_conv, ppx_tools,
 ppx_variants_conv, re, sexplib, variantslib, fieldslib}:

buildOcaml rec {
  name = "ppx_expect";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "13160qc98j9npmbl7lyv66zvyzzn61niqf5rxin8z20isikvg1rz";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_assert ppx_compare ppx_core ppx_custom_printf ppx_driver
      ppx_fields_conv ppx_here ppx_inline_test ppx_sexp_conv ppx_tools
      ppx_variants_conv re sexplib variantslib fieldslib ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Cram-like framework for OCaml";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
