{ rustPlatform, openssl, capnproto, which, postgresql, fetchFromGitHub }:
with rustPlatform;

buildRustPackage rec {
  name = "holmes";
  src  = fetchFromGitHub {
    owner = "maurer";
    repo  = "holmes";
    rev   = "45e9014cc05e5f3384ff67981007c26e043db9c4";
    sha256 = "1664ss0ax88i54agdiifzfdlrw0lzzdniwdfi8jsyibasd12j8ky";
  };
  doCheck = false;
  buildInputs = [ openssl capnproto which postgresql ];
  depsSha256 = "06mp063wk5yvf7nxxxhjys0nmklfx6i3iw5ggiss8r14iiwgg1iq";
}
