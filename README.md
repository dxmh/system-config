# My system configuration

My macOS setup with [nix](https://nixos.org) and [Homebrew](https://brew.sh), managed by [nix-darwin](https://github.com/LnL7/nix-darwin).

## Initial setup

On a fresh Mac, some setup is required before we can use `nix-darwin`:

### Nix

Install `nix` itself, as per the [nix installation docs](https://github.com/NixOS/nix#installation):

```shell
curl -L https://nixos.org/nix/install | sh
```

### Homebrew

Install `brew` (so we can manage GUI applications with nix-darwin), as per the [brew.sh instructions](https://brew.sh):

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Rosetta 2

Install [Rosetta](https://support.apple.com/en-gb/HT211861) if necessary:

```shell
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
```

### nix-darwin

Create the `/run` symlink that the [`nix-darwin` installer](https://github.com/LnL7/nix-darwin#install) would usually set up:

```shell
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```

Build our flake:

```shell
nix --experimental-features "nix-command flakes" \
	build github:dxmh/system-config#darwinConfigurations.setze.system
```


Now we can run `nix-darwin` for the first time:

```shell
./result/sw/bin/darwin-rebuild switch \
	--flake github:dxmh/system-config#setze
```