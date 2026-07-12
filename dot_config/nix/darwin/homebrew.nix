{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;

      # 移行中は none。
      # Homebrew 管理対象を完全に書き切ったら "uninstall" へ変更してよい。
      cleanup = "none";
      # cleanup = "uninstall";
    };

    taps = [
      "nikitabobko/tap"
    ];

    brews = [
      "mas"
    ];

    casks = [
      "ghostty"
      "raycast"
      "1password"
      "zed"
      "discord"

      # optional window manager
      {
        name = "nikitabobko/tap/aerospace";
        trusted = true;
      }

      # fonts
      "sf-symbols"
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
    ];

    masApps = {
      # "Line" = 497799835;
    };
  };
}
