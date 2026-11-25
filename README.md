# About
This is a flake containing a terminal version for
[papermono](https://github.com/paper-design/paper-mono.git) font. The original
font is actually on nixpkgs but not the appropriate terminal version. <br/>

Creditos to [Sam Potts](https://github.com/sampotts) for providing the
.ttf files on [this issue](https://github.com/paper-design/paper-mono/issues/14).<br/>

# Installation

Add the input in your flake.nix:
```nix
paper-mono-term = {
    url = "github:2besita/paper-mono-term-flake";
    inputs.nixpkgs.follows = "nixpkgs";
};
```
Then add the given input name on `outputs = { ... ]` and add the package wherever it
goes on your configuration:
```nix
inputs.paper-mono-term.packages.${pkgs.stdenv.hostPlatform.system}.default
```
