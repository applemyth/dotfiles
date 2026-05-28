if vim.g.ark_nvim_managed_by_nix ~= true then
  error("ark-nvim is Nix-managed. Activate the Home Manager flake before loading it.")
end

require("ark-nvim.preload")
require("ark-nvim.keymap")
require("ark-nvim.nix")
