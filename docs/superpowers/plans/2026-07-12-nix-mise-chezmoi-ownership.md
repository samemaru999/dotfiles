# Nix・mise・chezmoi Ownership Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Nix、Homebrew、chezmoi、miseの管理対象重複を解消し、新規Macで再現可能な設定にする。

**Architecture:** Determinate Nixの追加設定はnix-darwinへ集約し、HomebrewはGUIアプリのみを宣言する。chezmoiはflake.lockとユーザー設定を配布し、miseはNix提供の単一バイナリからlogin shell向けshim activationとinteractive shell向け通常activationを行う。

**Tech Stack:** Nix flakes、nix-darwin、Determinate Nix、Homebrew Bundle、chezmoi、zsh、mise

## Global Constraints

- 既存の未追跡ユーザーファイルを削除しない。
- `cleanup = "none"`と`mas`を維持する。
- secretを追加しない。
- 適用前に必ず評価を通す。

---

### Task 1: 再現可能なNix source

**Files:**
- Create: `dot_config/nix/flake.lock`
- Delete from management: `dot_config/nix/nix.conf`
- Modify: `dot_config/nix/darwin/system.nix`

- [ ] 実環境のflake.lockをchezmoi sourceへ取り込む。
- [ ] nix-community鍵と`extra-*`設定へ変更する。
- [ ] 一般ユーザーを`trusted-users`から外す。
- [ ] テンプレート展開とflake評価を実行する。

### Task 2: HomebrewとSketchybarの宣言整理

**Files:**
- Modify: `dot_config/nix/darwin/homebrew.nix`
- Modify: `dot_config/nix/darwin/system.nix`
- Delete: `dot_config/sketchybar/helpers/executable_install.sh`

- [ ] trust JSON activation scriptを削除し、AeroSpace cask trustへ置換する。
- [ ] Sketchybarのhome参照をnix-darwin config由来にする。
- [ ] SketchybarのPATHからフォントを除く。
- [ ] 旧Homebrewインストールhelperを削除する。

### Task 3: zshとmiseの単一化

**Files:**
- Modify: `dot_config/nix/darwin/pkgs.nix`
- Modify: `dot_config/zsh/dot_zprofile`
- Modify: `dot_config/zsh/dot_zshrc`

- [ ] 明示的に重複したzsh packageを削除する。
- [ ] zprofile側では`mise activate zsh --shims`、zshrc側では`mise activate zsh`を設定する。
- [ ] 固定Node PATHを削除する。
- [ ] Nix版miseでshimを再生成する。
- [ ] zsh構文を検証する。

### Task 4: 適用とHomebrew重複CLI削除

**Files:**
- Apply: chezmoi target and nix-darwin system configuration

- [ ] chezmoiを適用する。
- [ ] `nix flake check --no-build`を実行する。
- [ ] nix-darwinを適用する。
- [ ] Nix提供を確認できたHomebrew CLIだけをuninstallする。
- [ ] Nix設定、PATH、mise version、Git状態を最終確認する。
