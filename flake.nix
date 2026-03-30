{
  description = "okapi - find lines across files by regex and edit them all at once";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        okapi = pkgs.callPackage ./default.nix { };
      in
      {
        packages = {
          inherit okapi;
          default = okapi;
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ okapi ];
          packages = [
            pkgs.cargo
            pkgs.rust-analyzer
            pkgs.clippy
            pkgs.rustfmt
            pkgs.ripgrep
          ];
        };
      });
}
