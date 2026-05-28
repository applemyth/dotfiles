{ pkgs, ... }:

let
  arkNvimConfig = pkgs.vimUtils.buildVimPlugin {
    pname = "ark-nvim-config";
    version = "0.1.0";
    src = ../..;
    nvimSkipModules = [
      "init"
      "ark-nvim"
      "ark-nvim.nix"
    ];
  };

  treeSitterParserNames = [
    "blade"
    "c"
    "css"
    "html"
    "lua"
    "markdown"
    "markdown_inline"
    "php"
    "php_only"
    "query"
    "typescript"
    "vim"
    "vimdoc"
  ];

  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (parsers:
    map
      (name: parsers.${name})
      (builtins.filter (name: builtins.hasAttr name parsers) treeSitterParserNames));
in

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    initLua = ''
      vim.g.ark_nvim_managed_by_nix = true
      require("ark-nvim")
    '';

    extraPackages = with pkgs; [
      astro-language-server
      deno
      fd
      git
      intelephense
      lua-language-server
      prettier
      pyright
      ripgrep
      tailwindcss-language-server
      texlab
      typescript-language-server
      vim-language-server
      vscode-langservers-extracted
    ];

    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      fidget-nvim
      lualine-nvim
      luasnip
      neovim-ayu
      nvim-cmp
      nvim-lspconfig
      nvim-spectre
      nvim-tree-lua
      nvim-web-devicons
      plenary-nvim
      telescope-nvim
      telescope-undo-nvim
      treesitter
      vim-fugitive
      zen-mode-nvim
      arkNvimConfig
    ];
  };
}
