{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    bun
    fd
    fzf
    gh
    git
    nodejs
    postgresql
    ripgrep
    zoxide
  ];
}
