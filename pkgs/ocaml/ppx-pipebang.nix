{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_driver, ppx_tools}:

buildOcaml rec {
  name = "ppx_pipebang";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "19rj51yavzkpr8n89y7rnp8p2221j47zi2syww4z6slxcsmg0x68";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs = [ ppx_core ppx_driver ppx_tools ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $out";


  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "A ppx rewriter that inlines reverse application operators |> and |!";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
