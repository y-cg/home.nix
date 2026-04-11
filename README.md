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

To make sure the nix pick up the cache:

```sh
# if you use DeterminateSystems installer
echo 'trusted-users = root @wheel @sudo' | sudo tee -a /etc/nix/nix.custom.conf

# make sure restart the nix-daemon
sudo systemctl restart nix-daemon
```

## Usage

You can switch to the home configuration defined in this directory by running:

```sh
# in case that cache miss happens, you can set the negative ttl to 0 to avoid waiting for the cache to expire
# `-b` is for enabling the backup extension, which will backup the existing file that are not managed by home-manager.
nh home switch . -c <username>@<hostname> -b --accept-flake-config -- --option narinfo-cache-negative-ttl 0
```
