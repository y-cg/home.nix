{ ... }:
{
  programs.television = {
    enable = true;

    channels.files = {
      metadata = {
        name = "files";
        description = "A channel to select files and directories";
        requirements = [
          "fd"
          "bat"
        ];
      };

      # First entry is the default launch mode; subsequent entries are
      # reachable via Ctrl+S source cycling.
      source.command = [
        "fd -t f -H --exclude .git"
        "fd -t f"
      ];

      preview = {
        command = "bat -n --color=always '{}'";
        env = {
          BAT_THEME = "ansi";
        };
      };

      keybindings = {
        # Override the global `enter = "confirm_selection"` (which only
        # selects and exits) so Enter opens the selection in $EDITOR.
        enter = "actions:edit";
      };

      actions.edit = {
        description = "Opens the selected entries with the default editor (falls back to vim)";
        # `\${...}` escapes Nix string interpolation; the literal `${EDITOR:-vim}`
        # must reach the shell so television can resolve it at runtime.
        command = "\${EDITOR:-nvim} '{}'";
        shell = "bash";
        # use `mode = "fork"` if you want to return to tv afterwards
        mode = "execute";
      };

      # TODO: upstream 0.15.6 `files` cable also ships other actions.
      # Not carried over for now — re-add from upstream if those interactions are wanted later.
    };
  };
}
