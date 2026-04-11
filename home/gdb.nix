{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gdb
  ];

  programs.zsh.shellAliases = {
    gdb = "gdb -x ~/.gdbinit";
  };

  home.file.".gdbinit".text = ''
    set disassembly-flavor intel
    set confirm off

    alias stack = x/20wx $rsp
  '';
}
