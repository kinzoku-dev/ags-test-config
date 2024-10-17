{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    inherit self lib;

    devShells = forAllSystems (system: {
      default = import ./devshell.nix {
        inherit inputs;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      };
    });
  };
}
