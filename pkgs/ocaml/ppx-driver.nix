{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_optcomp}:

buildOcaml rec {
  name = "ppx_driver";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "1xr6mjv0nc407dzd4z8b454dl0q5cdp09ki81r9687zlsyfc0yfn";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_core ppx_optcomp ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "A driver is an executable created from a set of OCaml AST transformers linked together with a command line frontend.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
