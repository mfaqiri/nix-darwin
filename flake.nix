{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-mssql = {
        url = "github:Microsoft/homebrew-mssql-release";
        flake = false;
        };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nix-darwin,
    nix-homebrew,
    homebrew-cask,
    homebrew-core,
    homebrew-mssql,
    nvf,
    nixpkgs,
  } @ inputs: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#default
    darwinConfigurations."default" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
        nvf.nixosModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = "mfaqiri";

            autoMigrate = true;

            # Optional: Declarative tap management
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "Microsoft/homebrew-mssql-release" = homebrew-mssql;
            };

            # Optional: Enable fully-declarative tap management
            #
            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
            mutableTaps = true;
          };
        }
      ];
    };
  };
}
