{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # bootstrap / dotfiles
    chezmoi
    git
    gh
    just

    # shell / task runner
    tmux
    direnv
    mise

    # editor
    helix

    # Nix tooling
    nil
    nixfmt

    # basic CLI
    curl
    wget
    jq
    yq
    tree

    # modern CLI
    bat
    eza
    fd
    fzf
    ripgrep
    zoxide
  ];
}
