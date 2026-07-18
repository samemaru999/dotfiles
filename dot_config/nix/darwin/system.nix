{
  config,
  lib,
  pkgs,
  ...
}:

let
  sketchybar-app-font-bg = pkgs.stdenvNoCC.mkDerivation {
    pname = "sketchybar-app-font-bg";
    version = "0.0.11";

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/SoichiroYamane/sketchybar-app-font-bg/v0.0.11/public/dist/sketchybar-app-font-bg.ttf";
      hash = "sha256-1WfuPv9+q93tx56yEVCzlL8b+czvVRXjgMC2RMHFy50=";
    };

    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/share/fonts/truetype"
      install -m444 "$src" "$out/share/fonts/truetype/sketchybar-app-font-bg.ttf"
      runHook postInstall
    '';
  };
in
{
  determinateNix = {
    enable = true;
    customSettings = {
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  environment.variables = {
    ZDOTDIR = "$HOME/.config/zsh";
  };

  launchd.user.envVariables.PATH = lib.concatStringsSep ":" [
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/opt/homebrew/bin"
  ];

  programs.zsh.enable = true;

  fonts.packages = [
    pkgs.sketchybar-app-font
    sketchybar-app-font-bg
  ];

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults = {
    NSGlobalDomain = {
      NSAutomaticCapitalizationEnabled = false;
      # NSAutomaticDashSubstitutionEnabled = false;
      # NSAutomaticPeriodSubstitutionEnabled = false;
      # NSAutomaticQuoteSubstitutionEnabled = false;
      # NSAutomaticSpellingCorrectionEnabled = false;
    };

    dock = {
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };

    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 0;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
    };
  };

  services.sketchybar = {
    enable = true;
    config = ''
      export CONFIG_DIR="${config.system.primaryUserHome}/.config/sketchybar"
      export LUA_CPATH="${pkgs.sbarlua}/lib/lua/5.5/?.so;;"
      cd "$CONFIG_DIR"
      exec ${pkgs.lua5_5}/bin/lua "$CONFIG_DIR/sketchybarrc"
    '';

    extraPackages = with pkgs; [
      jq
      lua5_5
      nowplaying-cli
      sbarlua
      switchaudio-osx
    ];
  };

  # JankyBorders は設定ファイル型ではなく、nix-darwin option で管理する。
  services.jankyborders = {
    enable = true;

    width = 5.0;
    style = "round";
    order = "above";
    hidpi = true;

    active_color = "0xffe1e3e4";
    inactive_color = "0xff494d64";

    ax_focus = false;

    blacklist = [
      # "System Settings"
      # "Finder"
    ];
  };
}
