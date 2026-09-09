{ user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;          # fast key repeat
      InitialKeyRepeat = 15;  # short delay before repeat
      _HIHideMenuBar = true;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  # list view by default
    finder.CreateDesktop = false;          # clean desktop
    trackpad.Clicking = true;              # tap to click
  };
  nix-homebrew = {
    enable = true;
    inherit user;
    # cherryfunk already has a manually-installed Homebrew at /opt/homebrew.
    # This only deletes brew's own git-tracked core files; Cellar/Caskroom/Taps
    # (installed packages) are untracked in that repo and are left alone.
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";  # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    taps = [
      "aboudjem/tap"   # sleepless
      "supabase/tap"   # supabase
    ];
    brews = [
      "herdr"
      "bat"
      "chezscheme"
      "colima"
      "cpanminus"
      "docker"
      "docker-compose"
      "elan-init"
      "fd"
      "ffmpeg"
      "fzf"
      "gh"
      "graphviz"
      "lazygit"
      "libomp"
      "mongosh"
      "mupdf-tools"
      "neovim"
      "opentofu"
      "poppler"
      "python@3.12"
      "rclone"
      "ripgrep"
      "scw"
      "supabase"
      "tmux"
      "tree-sitter"
      "tree-sitter-cli"
      "uv"
      "yt-dlp"
    ];
    casks = [
      "wezterm"
      "claude-code"
      "alt-tab"
      "ausweisapp"
      "claude"
      "cursor"
      "detexify"
      "figma"
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "gcloud-cli"
      "google-chrome"
      "hiddenbar"
      "iterm2"
      "mactex"
      "macwhisper"
      "raycast"
      "signal"
      "skim"
      "sleepless"
      "transmission"
      "whatsapp"
      "zoom"
      "zotero"
    ];
  };
}
