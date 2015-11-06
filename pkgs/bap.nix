{stdenv, buildOcaml, camlp4, ocaml, findlib, fetchFromGitHub, fetchurl, ocaml_oasis, bitstring, camlzip, cmdliner, cohttp, core_kernel, ezjsonm, faillib, fileutils, ocaml_lwt, ocamlgraph, ocurl, re, uri, zarith, piqi, piqi-ocaml, uuidm, llvm_34, ulex, easy-format, xmlm, utop, which, makeWrapper, ncurses}:

# TODO buildOcaml doesn't have any way of knowing which ocaml it's using - this must be the same one we provide to bapbuild later in the environment overload
buildOcaml rec {
  name = "bap";
  version = "0.9.9";
  src = fetchFromGitHub {
    owner  = "BinaryAnalysisPlatform";
    repo   = "bap";
    rev    = "v0.9.9";
    sha256 = "0i0ikc12l8ss9f58qb1x1m40y7qpmarivggn7k1kbblgh5dsizwj";
  };

  sigs = fetchurl {
     url = "https://github.com/BinaryAnalysisPlatform/bap/releases/download/v0.9.9/sigs.zip";
     sha256 = "0mpsq2pinbrynlisnh8j3nrlamlsls7lza0bkqnm9szqjjdmcgfn";
  };

  createFindlibDestdir = true;

  buildInputs = [ ocaml findlib camlp4 ocaml_oasis bitstring camlzip cmdliner cohttp
                  core_kernel ezjsonm faillib fileutils ocaml_lwt
                  ocamlgraph ocurl re uri zarith piqi piqi-ocaml uuidm
                  llvm_34
                  #rdeps
                  utop
                  #build tricks
                  which
                  makeWrapper
                  ];
  propagatedBuildInputs = [ faillib bitstring camlzip cmdliner cohttp core_kernel ezjsonm fileutils ocaml_lwt ocamlgraph ocurl re uri zarith piqi piqi-ocaml uuidm ncurses ];


#TODO Exporting OCAMLPATH and PATH like this massively bloats the package, making it unsuitable for non-dev systems
  installPhase = ''
  cat <<EOF > baptop
  #!/bin/bash
  export OCAMLPATH=`echo $OCAMLPATH`:`echo $OCAMLFIND_DESTDIR`
  exec `which utop` -require bap.top "\$@"
  EOF
  make install
  wrapProgram $out/bin/bapbuild --suffix-each PATH : ${ocaml}/bin ${camlp4}/bin ${findlib}/bin --set OCAMLPATH `echo $OCAMLPATH`:`echo $OCAMLFIND_DESTDIR`
  ln -s $sigs $out/share/bap/sigs.zip
  '';

  configureFlags = "${if stdenv.isDarwin then "--with-cxxlibs=-lc++ " else ""}--with-llvm-config ${llvm_34}/bin/llvm-config";

  meta = with stdenv.lib; {
    description = "Platform for binary analysis. It is written in OCaml, but can be used from other languages.";
    homepage = https://github.com/BinaryAnalysisPlatform/bap/;
    license = licenses.mit;
  };
}
