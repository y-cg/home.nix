{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    initContent = lib.mkMerge [
      (lib.mkOrder 100 ''
        function zvm_config() {
          ZVM_KEYTIMEOUT=0.1
          ZVM_VI_INSERT_ESCAPE_BINDKEY=kk
        }
      '')
      (lib.mkOrder 900 ''
        # Source any dynamic zsh snippets if present.
        if [[ -d ~/.zsh/dynamic.d ]]; then
          for file in ~/.zsh/dynamic.d/*.zsh(N); do
            source "$file"
          done
        fi
      '')
    ];

  };
}
