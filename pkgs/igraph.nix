{stdenv, libxml2, fetchurl}:

stdenv.mkDerivation rec {
  name = "igraph";
  version = "0.7.1";
  buildInputs = [libxml2];
  src = fetchurl {
    url = "http://igraph.org/nightly/get/c/igraph-0.7.1.tar.gz";
    sha256 = "1pxh8sdlirgvbvsw8v65h6prn7hlm45bfsl1yfcgd6rn4w706y6r";
  };
}
