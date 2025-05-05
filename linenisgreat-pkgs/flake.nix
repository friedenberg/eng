{
  inputs = {
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.22.tar.gz";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2411.717296.tar.gz";
    utils.url = "https://flakehub.com/f/numtide/flake-utils/0.1.102.tar.gz";

    ssh.url = "path:./ssh";
    bash.url = "path:./bash";

    zit = {
      url = "github:friedenberg/zit?dir=go/zit";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    chrest = {
      url = "github:friedenberg/chrest?dir=go";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    chromium-html-to-pdf = {
      url = "github:friedenberg/chromium-html-to-pdf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };

    pa6e = {
      url = "github:friedenberg/peripage-A6-bluetooth";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , utils
    , zit
    , chrest
    , chromium-html-to-pdf
    , fh
    , pa6e
    , ssh
    , bash
    }:
    (utils.lib.eachDefaultSystem
      (system:
      let

        pkgs = import nixpkgs
          {
            inherit system;
          };

      in
      {
        packages = {
          default = with pkgs; symlinkJoin {
            failOnMissing = true;
            name = "linenisgreat-pkgs";
            paths = [
              bash.packages.${system}.default
              chrest.packages.${system}.default
              chromium-html-to-pdf.packages.${system}.html-to-pdf
              fh.packages.${system}.default
              pa6e.packages.${system}.pa6e-markdown-to-html
              ssh.packages.${system}.default
              zit.packages.${system}.default
            ];
          };
        };
      })
    );
}
