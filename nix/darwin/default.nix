{ pkgs, username, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  programs.zsh.enable = true;

  system.primaryUser = username;
  system.stateVersion = 6;
}
