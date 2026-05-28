{ ... }:

{
  imports = [
    ./git.nix
    ./packages.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs.home-manager.enable = true;

  # This controls Home Manager migration defaults. Do not bump it casually.
  home.stateVersion = "24.11";
}
