{
  pkgs,
  lib,
  ...
}:
# for full default options, see: `lazygit -c`
{
  programs.lazygit = {
    enable = true;
    settings = {
      # see: https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
      git.pagers = [
        # use `difft` for better diffs by default
        {
          externalDiffCommand = "${lib.getExe pkgs.difftastic} --color=always";
        }
        # delta for fallback
        {
          pager = "${lib.getExe pkgs.delta} --dark --paging=never";
        }
      ];
      gui = {
        theme = {
          selectedLineBgColor = [ "blue" ]; # make sure the selected line is easy to see
        };
      };
      keybinding = {
        universal = {
          prevItem-alt = "k";
          nextItem-alt = "j";
          # more intuitive than `h` and `l` for vertical movement
          prevBlock-alt = "K";
          nextBlock-alt = "J";
          # so use 'h' and 'l' for tab switching instead (tabs are horizontal)
          nextTab = "l";
          prevTab = "h";
        };
      };
    };
  };
}
