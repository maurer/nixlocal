{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_driver, ppx_tools, ppx_type_conv}:

buildOcaml rec {
  name = "ppx_compare";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "1x9d1gadv4dq8hifln9ljdx35chpkd9ibjc4cm8kv4j8z6jv2491";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ppx_core ppx_driver ppx_tools ppx_type_conv ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Generation of fast comparison functions from type expressions and definitions.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
