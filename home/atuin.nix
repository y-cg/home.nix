{ ... }:
let
  trim-ws = x: "^\s*${x}\s*$";
in
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      enter_accept = true;
      inline_height = 10;
      history_filter = [
        (trim-ws "ls")
        (trim-ws "pwd")
        (trim-ws "lg") # lazygit
        # zoxide
        (trim-ws "z .*")
        (trim-ws "zi .*")
      ];
    };
  };
}
