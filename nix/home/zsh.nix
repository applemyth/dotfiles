{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      v = "nvim";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
    };

    initContent = ''
      [ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"
      export PATH="$HOME/.local/bin:$PATH"

      PROMPT='%n %1~ %# '

      bindkey '^ ' autosuggest-accept

      WORDCHARS=' *?_-.[]~=&;!#$%^(){}<>/'
      autoload -Uz select-word-style
      select-word-style normal
      zstyle ':zle:*' word-style unspecified

      [ -f "$HOME/.secrets.zsh" ] && source "$HOME/.secrets.zsh"
    '';
  };

  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
