{stdenv, m4, fetchFromGitHub}:

stdenv.mkDerivation rec {
  name = "csmith";
  version = "075c863bb00407e98262a7a2b8989a413c467a5d";
  buildInputs = [ m4 ];
  src = fetchFromGitHub {
    owner = "csmith-project";
    repo  = "csmith";
    rev   = "075c863bb00407e98262a7a2b8989a413c467a5d";
    sha256 = "0cp95vhk78kiy32naf3xp3c5scw77qz51km2b65qr4bqvvg22rrp";
  };
}
