{stdenv, ocaml, buildOcaml, camlp4, findlib, fetchFromGitHub, fetchurl, ocaml_oasis, bitstring, camlzip, cmdliner, cohttp, core_kernel, ezjsonm, faillib, fileutils, ocaml_lwt, ocamlgraph, ocurl, re, uri, zarith, piqi, piqi-ocaml, uuidm, llvm_34, ulex, easy-format, xmlm, utop, which, makeWrapper, ncurses, frontc}:

# TODO buildOcaml doesn't have any way of knowing which ocaml it's using - this must be the same one we provide to bapbuild later in the environment overload
buildOcaml rec {
  name = "bap";
  version = "master";
  src = fetchFromGitHub {
    owner  = "BinaryAnalysisPlatform";
    repo   = "bap";
    rev    = "a98c94a0052ff9cff82af5cc2eb5e668234b68e5";
    sha256 = "0k0xnihl7yy845navy2zv77a2z36s8dl7vl950c2nvbbz57lqz04";
  };

  sigs = fetchurl {
     url = "https://github.com/BinaryAnalysisPlatform/bap/releases/download/v0.9.9/sigs.zip";
     sha256 = "0mpsq2pinbrynlisnh8j3nrlamlsls7lza0bkqnm9szqjjdmcgfn";
  };

  createFindlibDestdir = true;

  buildInputs = [ ocaml findlib camlp4 ocaml_oasis bitstring camlzip cmdliner cohttp
                  core_kernel ezjsonm faillib fileutils ocaml_lwt
                  ocamlgraph ocurl re uri zarith piqi piqi-ocaml uuidm frontc
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
