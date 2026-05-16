{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gdb
  ];

  programs.zsh.shellAliases = {
    gdb = "gdb -x ~/.gdbinit";
  };

  home.file.".gdbinit".text = ''
    set auto-load safe-path /
    set disassembly-flavor intel
    set confirm off

    alias st = x/20wx $rsp
  '';
}
