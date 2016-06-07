{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_deriving, ppx_driver, ppx_tools}:

buildOcaml rec {
  name = "ppx_type_conv";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "0dgpv30xw5rylaiczdmhvb09h010g5hils1chgawwiyqacjpdc5i";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_core ppx_deriving ppx_driver ppx_tools ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "The type_conv library factors out functionality needed by different preprocessors that generate code from type specifications.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
