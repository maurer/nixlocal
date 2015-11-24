{ stdenv, fetchurl, fetchFromGitHub, which, clang,
  libcap, linuxHeaders, libuv, imagemagick, discount, protobuf, coreutils }:

# XXX WARNING XXX
# This package includes several others by source.
# * This should not be taken as a guideline of what to do in general packaging.
# * This package does not benefit from build caching.
# * This package needs versions updated separately in case of security issues.
# * Dependency build mechanisms cannot be easily overridden.

# In the long run, someone (possibly me (maurer)) should figure out how to
# convince sandstorm/ekam to build against provided libraries.

stdenv.mkDerivation rec {
  name = "sandstorm-${version}";
  version = "broken";
  capnproto = fetchFromGitHub {
    owner  = "sandstorm-io";
    repo   = "capnproto";
    rev    = "b820678de0c630da3ef672688bcfd28b62f6c47c";
    sha256 = "149dx3gi122wixbv1ici4q36sdqlq8gdkalp3gc9qhfsq0vsvr3s";
  };
  ekam = fetchFromGitHub {
    owner  = "sandstorm-io";
    repo   = "ekam";
    rev    = "55b768c3a4bf6160596a47166f82f6b9e8ba4125";
    sha256 = "0qsm40vf2hh3vddlfms6fgjdpdsfndkwm0bzlama9pxj7di7pqkf";
  };
  libseccomp = fetchFromGitHub {
    owner  = "seccomp";
    repo   = "libseccomp";
    rev    = "7f3ae6e6a12390bd38f0787b242f60c47ad076c3";
    sha256 = "1krar51wq37r8nz3l73p17jnfqi4c5syd0gwnq05vz8xxj0rf5bh";
  };
  libsodium = fetchFromGitHub {
    owner  = "jedisct1";
    repo   = "libsodium";
    rev    = "stable";
    sha256 = "1rwzdljawy64ilja3vhxg8zfq22ch6r60jc775a48nvbf6q5ssmq";
  };
  es6-promise = fetchurl {
    url = "https://es6-promises.s3.amazonaws.com/es6-promise-2.0.1.min.js";
    sha256 = "173icn99hcfi9yigv6d35vrh0w7i3yyphd68avy19v8wdj8kwhjg";
  };
  sandstorm-rev = "d3c79117f257a01e35f83efc29e83e347b1b5978";
  sandstorm-src = fetchFromGitHub {
    owner  = "sandstorm-io";
    repo   = "sandstorm";
    rev    = sandstorm-rev;
    sha256 = "0ip6xv983jali6kic9l8fnpwk5ny1d7xc9sq30ibwhaxdw9a769k";
  };
  srcs = [ capnproto ekam libseccomp libsodium sandstorm-src ];
  buildInputs = [ libcap linuxHeaders clang which libuv imagemagick
                  discount protobuf coreutils ];
  sourceRoot = "sandstorm-${sandstorm-rev}-src";
  patches = [ ./dedep.patch ];
  postUnpack = ''
    # Load deps into deps folder.
    # Use cp instead of ln to avoid permission issues
    mkdir -p ${sourceRoot}/deps
    cp -r `realpath capnproto*`  ${sourceRoot}/deps/capnproto
    cp -r `realpath ekam*`       ${sourceRoot}/deps/ekam
    cp -r `realpath libseccomp*` ${sourceRoot}/deps/libseccomp
    cp -r `realpath libsodium*`  ${sourceRoot}/deps/libsodium
    # Files are created in here, we need to make sources writeable
    chmod -R u+rw ${sourceRoot}/deps
    mkdir -p tmp
  '';
  postPatch = ''
    # We don't have traditional /usr/include
    sed -e 's#/usr/include/linux#${linuxHeaders}/include/linux#' \
      -i src/sandstorm/ip_tables.ekam-rule
    # We don't have a /bin/true
    sed -e 's#/bin/true#${coreutils}/bin/true#' \
      -i src/sandstorm/util-test.c++
  '';
  # Ekam uses "intercept.so", a trick for fake filesystems. NIX_ENFORCE_PURITY
  # prevents this, so we disable purity during building.
  buildPhase = ''
    NIX_ENFORCE_PURITY=0 make tmp/.ekam-run
  '';
  installPhase = ''
    install -D bin/spk $out/bin/spk
  '';
}
