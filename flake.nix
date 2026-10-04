{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim.url = "github:pfassina/lazyvim-nix";

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      stylix,
      ...
    }:
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
    let
      nixosModules = [
        stylix.nixosModules.stylix
        ./all.nix
        home-manager.nixosModules.home-manager
        homeManagerModule
      ];

      mkNixos =
        hostModule: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = nixosModules ++ [ hostModule ] ++ extraModules;
        };
    in
    {
      /*
        Real NixOS installations
        ================================================================
      */

      nixosConfigurations.sleepy = mkNixos ./hosts/sleepy.nix [ ];

      nixosConfigurations.sneezy = mkNixos ./hosts/sneezy.nix [ ];

      nixosConfigurations.fatty = mkNixos ./hosts/fatty.nix [ ];

      /*
        Interactive regression VM
        ================================================================
      */

      nixosConfigurations.vm = mkNixos ./vm.nix [ ];

      /*
        Interactive regression VM with Ollama
        ================================================================
      */

      nixosConfigurations.ollama-vm = mkNixos ./vm.nix [ ./modules/ollama.nix ];
    };
}
