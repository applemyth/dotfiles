{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "applemyth";
    userEmail = "116312778+applemyth@users.noreply.github.com";

    aliases = {
      nccommit = "commit -a --allow-empty-message -m \"\"";
    };

    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    } // lib.optionalAttrs pkgs.stdenv.isDarwin {
      credential = {
        useHttpPath = true;
        helper = "osxkeychain";
      };
    };
  };

  programs.gh.enable = true;
}
