{stdenv, buildOcaml, fetchurl, ocaml_oasis, js_build_tools, opam,
 ppx_core, ppx_tools}:

buildOcaml rec {
  name = "ppx_optcomp";
  version = "113.33";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "054dpm818bz2x6552qw542rrp7y1zwg3w0gjp4hfjqbwd9xcbhgm";
  };

  hasSharedObjects = true;

  buildInputs = [ ocaml_oasis js_build_tools opam ];
  propagatedBuildInputs =
    [ ppx_core ppx_tools ];

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    description = "ppx_optcomp stands for Optional Compilation. It is a tool used to handle optional compilations of pieces of code depending of the word size, the version of the compiler, etc.";
    maintainers = [ maintainers.maurer ];
    license = licenses.asl20;
  };
}
