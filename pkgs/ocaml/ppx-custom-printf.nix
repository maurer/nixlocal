{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_driver, ppx_sexp_conv, ppx_tools}:

buildOcaml rec {
  name = "ppx_custom_printf";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "0w10hja2nv6dycqqlgfs5aw856i86abbdkjgqm9m9j1p86l9sqsg";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_driver ppx_sexp_conv ppx_tools ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Extensions to printf-style format-strings for user-defined string conversion.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
