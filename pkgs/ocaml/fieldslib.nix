{ stdenv, fetchurl, ocaml, findlib, type_conv, camlp4, ocaml_oasis, opam, js_build_tools }:

assert stdenv.lib.versionOlder "4.00" (stdenv.lib.getVersion ocaml);

stdenv.mkDerivation rec {
  name = "fieldslib";
  version = "113.33.03";

  src = fetchurl {
    url = "https://github.com/janestreet/${name}/archive/${version}.tar.gz";
    sha256 = "0mkbix32f8sq32q81hb10z2q31bw5f431jxv0jafbdrif0vr6xqd";
  };

  buildInputs = [ ocaml findlib opam ocaml_oasis js_build_tools ];
  propagatedBuildInputs = [ type_conv camlp4 ];

  createFindlibDestdir = true;

  dontAddPrefix = true;

  configurePhase = "./configure --prefix $prefix";

  buildPhase = "OCAML_TOPLEVEL_PATH=`ocamlfind query findlib`/.. make";

  installPhase = "opam-installer -i --prefix $prefix --libdir `ocamlfind printconf destdir` ${name}.install";

  meta = with stdenv.lib; {
    homepage = https://ocaml.janestreet.com/;
    description = "OCaml syntax extension to define first class values representing record fields, to get and set record fields, iterate and fold over all fields of a record and create new record values";
    license = licenses.asl20;
    maintainers = [ maintainers.vbgl ];
    platforms = ocaml.meta.platforms or [];
  };
}
