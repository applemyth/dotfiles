{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user = {
        name = "applemyth";
        email = "116312778+applemyth@users.noreply.github.com";
      };

      alias = {
        nccommit = "commit -a --allow-empty-message -m \"\"";
      };

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
