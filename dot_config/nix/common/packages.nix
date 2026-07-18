{ pkgs }:

[
  # bootstrap / dotfiles
  pkgs.chezmoi
  pkgs.git
  pkgs.gh
  pkgs.just

  # shell / task runner
  pkgs.tmux
  pkgs.direnv
  pkgs.mise

  # editor
  pkgs.helix

  # Lean toolchain manager
  pkgs.elan

  # Nix tooling
  pkgs.nil
  pkgs.nixfmt

  # basic CLI
  pkgs.curl
  pkgs.wget
  pkgs.jq
  pkgs.yq
  pkgs.tree

  # modern CLI
  pkgs.bat
  pkgs.eza
  pkgs.fd
  pkgs.fzf
  pkgs.ripgrep
  pkgs.zoxide
]
