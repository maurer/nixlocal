{stdenv, writeText, fetchurl, ocaml, ocplib-endian, sexplib, findlib,
 async ? null, lwt ? null, camlp4}:

assert stdenv.lib.versionAtLeast (stdenv.lib.getVersion ocaml) "4.01";

stdenv.mkDerivation rec {
  name = "ocaml-cstruct";
  version = "2.1.0";

  src = fetchurl {
    url = "https://github.com/mirage/ocaml-cstruct/archive/v${version}.tar.gz";
    sha256 = "18f9jgrg54zdwaadagla67q6n8hbi9xsj8dk21l74pxgadbm5dps";
  };

  configureFlags = stdenv.lib.strings.concatStringsSep " " ((if lwt != null then ["--enable-lwt"] else []) ++
                                          (if async != null then ["--enable-async"] else []));
  buildInputs = [ocaml findlib camlp4];
  propagatedBuildInputs = [ocplib-endian sexplib lwt async];

  createFindlibDestdir = true;
  dontStrip = true;

  meta = with stdenv.lib; {
    homepage = https://github.com/mirage/ocaml-cstruct;
    description = "Map OCaml arrays onto C-like structs";
    license = stdenv.lib.licenses.isc;
    maintainers = [ maintainers.vbgl maintainers.ericbmerritt ];
    platforms = ocaml.meta.platforms or [];
  };
}
