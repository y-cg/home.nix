{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "y-cg";
        email = "159802291+y-cg@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        dl = "log -p --ext-diff";
      };

      push = {
        autoSetupRemote = true;
      };

      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere = {
        enabled = true;
      };

      # let git handle the whitespace in a proper way
      apply = {
        ignoreWhitespace = "change";
        whitespace = "fix";
      };
    };
  };

}
