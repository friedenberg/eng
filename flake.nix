{
  inputs = {
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.717296.tar.gz";
    utils.url = "https://flakehub.com/f/numtide/flake-utils/0.1.102.tar.gz";

    system-packages-common.url =
      "path:./dev-flake-templates/system-packages-common";

    system-packages-darwin.url =
      "path:./dev-flake-templates/system-packages-darwin";

    system-packages-linux.url =
      "path:./dev-flake-templates/system-packages-linux";

    linenisgreat-pkgs.url =
      "path:./linenisgreat-pkgs";

    nix.url =
      "path:./dev-flake-templates/nix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , utils
    , nix
    , system-packages-common
    , system-packages-darwin
    , system-packages-linux
    , linenisgreat-pkgs
    }:
    (utils.lib.eachDefaultSystem
      (system:
      let

        pkgs = import nixpkgs {
          inherit system;
        };


      in
      {
        packages.default = pkgs.symlinkJoin {
          failOnMissing = true;
          name = "system-packages";
          paths = [
            system-packages-common.packages.${system}.default
            {
              x86_64-linux = system-packages-linux;
              x86_64-darwin = system-packages-darwin;
            }.${system}.packages.${system}.default
            linenisgreat-pkgs.packages.${system}.default
          ];
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            nix.devShells.${system}.default
          ];
        };
      })
    );
}
