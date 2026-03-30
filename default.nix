{
  lib,
  rustPlatform,
  makeWrapper,
  ripgrep,
  fetchFromGitHub,
}:

let
  version = "0.4.1";
  src = fetchFromGitHub {
    owner = "nk9";
    repo = "okapi";
    rev = "v${version}";
    hash = "sha256-Xnckb3CMB8lE1oaEbmy8etRGJB5BuSoHts0phXm48uM";
  };
in
rustPlatform.buildRustPackage {
  pname = "okapi";

  inherit src version;

  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/okapi \
      --prefix PATH : ${lib.makeBinPath [ ripgrep ]}
  '';

  meta = {
    description = "Find lines across files by regex and edit them all at once with your $EDITOR";
    homepage = "https://github.com/nk9/okapi";
    license = lib.licenses.asl20;
    mainProgram = "okapi";
  };
}
