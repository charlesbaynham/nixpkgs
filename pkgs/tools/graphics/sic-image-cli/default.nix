{ lib, rustPlatform, fetchFromGitHub, installShellFiles, nasm }:

rustPlatform.buildRustPackage rec {
  pname = "sic-image-cli";
  version = "0.22.0";

  src = fetchFromGitHub {
    owner = "foresterre";
    repo = "sic";
    rev = "v${version}";
    sha256 = "sha256-ZKxBanCfPBo5k1EI/cJKpHiWF7M1blZdchWy3DMHrnQ=";
  };

  cargoSha256 = "sha256-cj9UAPwgj4ZT+ReZWi9hOBNicMBOt9qdveYYF5CFapw=";

  nativeBuildInputs = [ installShellFiles nasm ];

  postBuild = ''
    cargo run --example gen_completions
  '';

  postInstall = ''
    installShellCompletion sic.{bash,fish}
    installShellCompletion --zsh _sic
  '';

  meta = with lib; {
    description = "Accessible image processing and conversion from the terminal";
    homepage = "https://github.com/foresterre/sic";
    changelog = "https://github.com/foresterre/sic/blob/v${version}/CHANGELOG.md";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ figsoda ];
    mainProgram = "sic";
  };
}
