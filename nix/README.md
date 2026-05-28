# Nix Home Manager Setup

This repo can be used as a Home Manager flake for a terminal environment plus
a Nix-managed Neovim setup.

Apply the current macOS profile:

```sh
home-manager switch --flake .#hershybar@macbook
```

Standalone Home Manager profile names are generated as
`<username>@<hostname>` from the `hosts` map in `flake.nix`.

Apply the full macOS system profile with nix-darwin:

```sh
sudo darwin-rebuild switch --flake .#macbook
```

For strict Nix ownership, keep this repo outside `~/.config/nvim`.
The current canonical location is:

```sh
~/.dotfiles
```

Then let Home Manager provide the active `nvim`. Keeping the source repo at
`~/.config/nvim` leaves unmanaged Lua files on Neovim's default runtime path.

Add or change a machine by editing `hosts` in `flake.nix`:

```nix
linuxbox = {
  username = "alex";
  system = "x86_64-linux";
};
```

The home directory is derived from the platform by default:

- Darwin systems use `/Users/<username>`.
- Linux systems use `/home/<username>`.

Set `homeDirectory` only when a machine uses a non-standard path.

Then apply it:

```sh
home-manager switch --flake .#alex@linuxbox
```

Secrets are intentionally not declared here. Put API keys in:

```sh
~/.secrets.zsh
```

That file is sourced by the ZSH module when it exists.

Neovim is managed by `nix/modules/nvim.nix`:

- `programs.neovim.plugins` declares Vim plugins.
- `programs.neovim.extraPackages` declares LSP servers and CLI tools used by plugins.
- `programs.neovim.extraLuaConfig` loads `lua/ark-nvim`.
- `ark-nvim-config` packages this repo as a Vim plugin, so local Lua modules
  and query files live in the Nix store.

Lazy.nvim and Mason are no longer part of the active startup path. Nix owns
plugin installation and language-server installation.

Because this is a flake in a Git repo, stage or commit newly added files before
switching. Otherwise Nix may ignore untracked files.

After Nix is installed, pin the flake inputs with:

```sh
nix flake lock
git add flake.lock
git commit -m "Add flake lockfile"
```
