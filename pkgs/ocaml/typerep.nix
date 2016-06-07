{stdenv, buildOcaml, fetchurl, type_conv, opam, ocaml_oasis, js_build_tools}:

buildOcaml rec {
  name = "typerep";
  version = "113.33.03";

  minimumSupportedOcamlVersion = "4.00";

  src = fetchurl {
    url = "https://github.com/janestreet/typerep/archive/${version}.tar.gz";
    sha256 = "1ss34nq20vfgx8hwi5sswpmn3my9lvrpdy5dkng746xchwi33ar7";
  };

  buildInputs = [ opam ocaml_oasis js_build_tools ];

  propagatedBuildInputs = [ type_conv ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    homepage = https://github.com/janestreet/typerep;
    description = "Runtime types for OCaml (beta version)";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };

}
