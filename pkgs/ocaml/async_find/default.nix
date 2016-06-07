{stdenv, buildOcamlJane, fetchurl, async, core, sexplib}:

buildOcamlJane rec {
  name = "async_find";
  hash = "4f3fda72f50174f05d96a5a09323f236c041b1a685890c155822956f3deb8803";
  propagatedBuildInputs = [ async core sexplib ];

  meta = with stdenv.lib; {
    homepage = https://github.com/janestreet/async_find;
    description = "Directory traversal with Async";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
