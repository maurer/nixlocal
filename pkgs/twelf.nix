{stdenv, mlton, fetchFromGitHub}:

stdenv.mkDerivation rec {
  name = "twelf";
  version = "1.7.1";
  buildInputs = [ mlton ];
  src = fetchFromGitHub {
    owner = "standardml";
    repo = "twelf";
    rev = "35216e78de99558a39b147bf06fef85e1aabb2c6";
    sha256 = "0afi52wls0a3jhbngj3ay91ai4j9va9qdkjqqajyc7wzc8gdh3yw";
  };
  patchPhase = ''
    sed -i bin/buildid -e s/^REV=.\*\$/REV=${version}/g
    sed -i bin/buildid -e s/^HOST=.\*\$/HOST=nixbuild/g
  '';
  buildPhase = "make mlton";
  installPhase = ''
    mkdir -p $out/bin
    DESTDIR=$out make install
  '';
}
