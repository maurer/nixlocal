{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_tools, ppx_type_conv}:

buildOcaml rec {
  name = "ppx_enumerate";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "0nz9s9ma5kgnvd8bs0q589lfii7sa5nq27x66nbdf5dj1jg76zaa";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_tools ppx_type_conv ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "Generate a list containing all values of a finite type.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
