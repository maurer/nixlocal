{ rustPlatform, libbap, fetchFromGitHub }:
with rustPlatform;

buildRustPackage rec {
  name = "bap-rust";
  src  = fetchFromGitHub {
    owner  = "maurer";
    repo   = "bap-rust";
    rev    = "6a3d4ece3b6b2f4ad815201238fcfc76bcc69802";
    sha256 = "10qdwxjsbnyqnbj44h9fyvdda76599p4y3i523c2faqzlhrcnqcd";
  };
  buildInputs = [ libbap ];
  depsSha256 = "04i8sdi0gys0pfqv1wq6z67hvzjw08zgb3754xqjim2saiphm8av";
}
