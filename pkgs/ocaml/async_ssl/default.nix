{stdenv, buildOcamlJane, fetchurl, async, comparelib, core, ctypes, openssl,
 fieldslib, herelib, pipebang, sexplib}:

buildOcamlJane rec {
  name = "async_ssl";
  sha256 = "1c0bfa92142eef11da6bf649bbe229bd4b8d9cc807303d8142406908c0d28c68";
  propagatedBuildInputs = [ ctypes async comparelib core fieldslib
                            herelib pipebang sexplib openssl ];

  meta = with stdenv.lib; {
    homepage = https://github.com/janestreet/async_ssl;
    description = "Async wrappers for ssl";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
