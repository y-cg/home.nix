{ meta, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "${meta.whoami}";
  home.homeDirectory = "/home/${meta.whoami}";

  # See release notes for version changes and migration notes.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
