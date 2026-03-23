{ pkgs, lib, ... }:

let
  tmux-nord = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "nord";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "nordtheme";
      repo = "tmux";
      rev = "f7b6da07ab55fe32ee5f7d62da56d8e5ac691a92";
      hash = "sha256-mcmVYNWOUoQLiu4eM/EUudRg67Gcou13xuC6zv9aMKA=";
    };
    patchPhase = ''
      sed -i '1i\#!/usr/bin/env bash' nord.tmux
    '';
  };
in
{
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.zsh;
    terminal = "xterm-256color";
    plugins = [
      {
        plugin = tmux-nord;
        extraConfig = "";
      }
    ];
    extraConfig = ''
      # use login shell to make sure ~/.zshenv is being read
      set -g default-command "${lib.getExe pkgs.zsh} -l"

      # faster command sequences
      set -s escape-time 10

      # Command prompt alias: type `:reload` to source ~/.config/tmux/tmux.conf
      # Use a high array index to avoid colliding with aliases defined elsewhere.
      set -s command-alias[100] reload="source-file ~/.config/tmux/tmux.conf"

      # increase repeat timeout
      set -sg repeat-time 600

      set -g default-terminal "screen-256color"

      # Vim-like keymapping
      setw -g mode-keys vi

      # Vim-like selection in copy-mode (v to select, y to yank)
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi V send -X select-line
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      # Esc behaves like Vim: selection -> normal, normal -> exit copy-mode
      bind -T copy-mode-vi Escape if-shell -F "#{selection_active}" "send -X clear-selection" "send -X cancel"

      # Vim-like pane switching
      bind -n -r C-p select-pane -t :.+

      # Switch between windows
      bind -n M-l select-window -t :+1
      bind -n M-h select-window -t :-1

      # New windows inherit current path
      bind c new-window -c "#{pane_current_path}"

      # Keep tmux's default split keys, but make new panes start in the
      # active pane's working directory instead of the server's default path.
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Fix color
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -g default-terminal "xterm-256color"

      # use mouse in tmux
      set -g mouse on
    '';
  };
}
