{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_driver, ppx_here, ppx_sexp_conv, ppx_tools}:

buildOcaml rec {
  name = "ppx_sexp_message";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "10z9z5sjhga4m58si28xq4rakapcfzwzxdj729h65q095dly0m27";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_driver ppx_here ppx_sexp_conv ppx_tools ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Easy construction of S-Expressions";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
