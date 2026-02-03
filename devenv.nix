{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    fzf
    jq
    nh
  ];

  # https://devenv.sh/languages/
  languages = {
    nix.enable = true;
  };

  # https://devenv.sh/scripts/
  scripts.list-configurations.exec = ''
    nix eval .#homeConfigurations --apply builtins.attrNames --json
  '';

  scripts.switch.exec = ''
    list-configurations | jq -r '.[]' | fzf --bind 'enter:become(nh home switch . -c {})'
  '';

  # https://devenv.sh/git-hooks/
  git-hooks = {
    hooks = {
      nixfmt.enable = true;
    };
    package = pkgs.prek;
  };

  # See full reference at https://devenv.sh/reference/options/
}
