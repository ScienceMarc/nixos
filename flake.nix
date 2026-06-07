{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: with inputs; {
    defaultPackage = home-manager.defaultPackage;
    homeConfigurations = {
      marc = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          # required by logseq and obsidian
          config.permittedInsecurePackages = [
            "electron-27.3.11"
          ];
        };
        extraSpecialArgs = { 
          pkgs-unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };

          pkgs-master = import nixpkgs-master {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [ ./home.nix ];
      };
    };
    nixosConfigurations = {
      "marc-fw13" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	      modules = [ ./system/laptop.nix nixos-hardware.nixosModules.framework-13-7040-amd ];
      };
      "marc-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./system/desktop.nix 
          inputs.disko.nixosModules.disko
        ];
      };
    };
  };
}
