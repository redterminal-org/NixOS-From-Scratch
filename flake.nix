{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs = { self, nixpkgs, home-manager, lazyvim, ... }:
    let
      system = "x86_64-linux";

      /*
        Shared Home Manager configuration.

        The exact same Home Manager configuration is used by the
        real system and by the interactive regression VM.
      */
      homeManagerModule = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          extraSpecialArgs = {
            inherit lazyvim;
          };

          users.root = import ./modules/root-home.nix;
          users.daniel = import ./home.nix;

          backupFileExtension = "backup";
        };
      };
    in
    {
      /*
        ================================================================
        Real NixOS installation
        ================================================================
      */

      nixosConfigurations.nixos =
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./all.nix
            ./real.nix

            home-manager.nixosModules.home-manager
            homeManagerModule
          ];
        };

      /*
        ================================================================
        Interactive regression VM
        ================================================================
      */

      nixosConfigurations.vm =
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./all.nix
            ./vm.nix

            home-manager.nixosModules.home-manager
            homeManagerModule
          ];
        };
    };
}
