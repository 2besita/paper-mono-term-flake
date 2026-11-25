{
    description = "paper-mono-term font";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager }:
    let
        systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
        forAll = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in {
        packages = forAll (pkgs: {
            default = pkgs.stdenvNoCC.mkDerivation {
            pname = "paper-mono-term";
            version = "1.0";
            src = builtins.path { path = ./fonts; name = "paper-mono-term-src"; };
            installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp -r $src/*.ttf $out/share/fonts/truetype/
            '';
            };
        });

        homeManagerModules.default = { pkgs, ... }: {
            home.packages = [ self.packages.${pkgs.system}.default ];
        };
    };
}
