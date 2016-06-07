{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, ppx_tools, opam}:

buildOcaml rec {
  name = "ppx_core";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "00jnm016zhynipqzn3kva322lywjg1ab2kn303grgnz4b0a04l70";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_tools ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "PPX standard library";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
