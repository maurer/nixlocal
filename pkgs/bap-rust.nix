{ rustPlatform, libbap, fetchFromGitHub }:
with rustPlatform;

buildRustPackage rec {
  name = "bap-rust";
  src  = fetchFromGitHub {
    owner  = "maurer";
    repo   = "bap-rust";
    rev    = "67a0f70d44c7e6b82c9540bf872cd4cb5547fcfe";
    sha256 = "0fyky7s0skrlhg8db85mlhpzrhjzjah4axf3cnpbs0ak8g7yj6h3";
  };
  buildInputs = [ libbap ];
  depsSha256 = "15db80nmsypcdmfv78jc31pkl9rbkila4aya606krqkd6hbciw24";
}
