{
  inputs,
  pkgs,
  ...
}:
inputs.devenv.lib.mkShell {
  inherit inputs pkgs;

  modules = [
    (
      {pkgs, ...}: {
        packages = with pkgs; [
          cachix
          deadnix
          statix
          nixd
          ags
        ];

        dotenv.enable = true;

        languages.rust = {
          enable = true;
        };
      }
    )
  ];
}
