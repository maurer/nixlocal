{stdenv, lib, fetchFromGitHub, fetchurl,
 # Build Tools
 ocaml, findlib, ocaml_oasis, ounit, which,
 # OCaml Deps
 bitstring, camlzip, cmdliner, ppx_jane, core_kernel, ezjsonm, faillib,
 fileutils, frontc, ocamlgraph, ocurl, ocaml_optcomp, re, uri, utop, zarith,
 uuidm, piqi-ocaml,
 # Other Deps
 llvm_34,
 # Nix Build Deps
 makeWrapper,
 # Nix Lib Deps
 writeText}:


stdenv.mkDerivation rec {
  name = "bap";
  version = "master";
  src = fetchFromGitHub {
    owner  = "BinaryAnalysisPlatform";
    repo   = "bap";
    rev    = "baf2b9d2b92e54bc43f8d8ae525e267aa9ff2b1c";
    sha256 = "1mc44wl2d82glwj616js98vfh6mj6nhlf6f5ql4ks6hfl0swcrr0";
  };

  ocaml_version = (builtins.parseDrvName ocaml.name).version;

  sigs = fetchurl {
     url = "https://github.com/BinaryAnalysisPlatform/bap/releases/download/v0.9.9/sigs.zip";
     sha256 = "0mpsq2pinbrynlisnh8j3nrlamlsls7lza0bkqnm9szqjjdmcgfn";
  };

  createFindlibDestdir = true;

  buildInputs = [ ocaml findlib ocaml_oasis ounit which
                  llvm_34
                  makeWrapper ];
  propagatedBuildInputs =
   [ bitstring camlzip cmdliner ppx_jane core_kernel ezjsonm faillib
     fileutils frontc ocamlgraph ocurl ocaml_optcomp re uri utop zarith
     uuidm piqi-ocaml ];

  setupHook = writeText "setupHook.sh" ''
    export CAML_LD_LIBRARY_PATH="''${CAML_LD_LIBRARY_PATH}''${CAML_LD_LIBRARY_PATH:+:}''$1/lib/ocaml/${ocaml_version}/site-lib/${name}/"
  '';

#TODO Exporting OCAMLPATH and PATH like this massively bloats the package, making it unsuitable for non-dev systems
  installPhase = ''
  cat <<EOF > baptop
  #!/bin/bash
  export OCAMLPATH=`echo $OCAMLPATH`:`echo $OCAMLFIND_DESTDIR`
  exec ${utop}/bin/utop -require bap.top "\$@"
  EOF
  make install
  wrapProgram $out/bin/bapbuild --prefix PATH : ${ lib.makeBinPath [ ocaml findlib ] } --set OCAMLPATH `echo $OCAMLPATH`:`echo $OCAMLFIND_DESTDIR`
  ln -s $sigs $out/share/bap/sigs.zip
  '';

  configureFlags = "${if stdenv.isDarwin then "--with-cxxlibs=-lc++ " else ""}--with-llvm-config ${llvm_34}/bin/llvm-config --enable-everything --enable-tests --ida-plugin-path $prefix/ida --ida-headless /home/maurer/.bin";

  meta = with stdenv.lib; {
    description = "Platform for binary analysis. It is written in OCaml, but can be used from other languages.";
    homepage = https://github.com/BinaryAnalysisPlatform/bap/;
    license = licenses.mit;
  };
}
