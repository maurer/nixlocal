{stdenv, jdk, fetchFromGitHub}:

stdenv.mkDerivation rec {
  name = "jakstab";
  version = "2555a70ef6ae4fb5f0d222a479b02da4d9a68e62";
  buildInputs = [ jdk ];
  src = fetchFromGitHub {
    owner = "jkinder";
    repo  = "jakstab";
    rev   = "2555a70ef6ae4fb5f0d222a479b02da4d9a68e62";
    sha256 = "1ca503dd8kd6rbp1z62vaxcd1n6p8fvqr5i1d3llncrr5ymw5gwa";
  };
  JAVA_TOOL_OPTIONS = "-Dfile.encoding=UTF8";
  buildPhase = "bash ./compile.sh";
  installPhase = ''
    install -D jakstab $out/wrap/jakstab
    cp -r bin $out/wrap/bin
    cp -r lib $out/wrap/lib
    cp -r ssl $out/wrap/ssl
    cp -r stubs $out/wrap/stubs
    mkdir -p $out/bin
    cat << EOF > $out/bin/jakstab
    #!/bin/bash
    exec $out/wrap/jakstab \$@
    EOF
    chmod +x $out/bin/jakstab
  '';
}
