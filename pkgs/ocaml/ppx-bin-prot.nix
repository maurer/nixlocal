{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_tools, ppx_type_conv, bin_prot}:

buildOcaml rec {
  name = "ppx_bin_prot";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "1h9qjwm32ixwgsj5lrlzqmyj7kl4abxx8kqh3s8v1wingbbsnypa";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_tools ppx_type_conv bin_prot ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Generation of bin_prot readers and writers from types";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
