# Home.nix

## Bootstrap

Install nix with [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

Flake support should be enabled by default. Then install [`nh`](https://github.com/nix-community/nh)

```sh
nix shell 'nixpkgs#nh'
```

## Usage

You can switch to the home configuration defined in this directory by running:

```sh
nh home switch . -c <username>@<hostname>
```
