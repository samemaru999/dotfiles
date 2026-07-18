{
  description = "Cross-platform environment managed by chezmoi, Nix, and nix-darwin";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      determinate,
      nixpkgs,
      nix-darwin,
      ...
    }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      darwinConfigurations.current = nix-darwin.lib.darwinSystem {
        modules = [
          determinate.darwinModules.default
          ./darwin/config.nix
        ];
      };

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          commonPackages = import ./common/packages.nix { inherit pkgs; };
          platformPackages =
            if pkgs.stdenv.isLinux then import ./linux/packages.nix { inherit pkgs; } else [ ];
        in
        {
          default = pkgs.buildEnv {
            name = "user-environment";
            paths = commonPackages ++ platformPackages;
          };
        }
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
