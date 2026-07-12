# dotfiles

macOS向けのユーザー設定とマシン構成を管理する。

## 所有権

- nix-darwin: macOS設定、常設CLI、Sketchybarなどのサービス
- Homebrew: GUIアプリとMac固有アプリ
- chezmoi: `$HOME`以下の設定ファイル
- mise: プロジェクトごとのランタイム、環境変数、tasks

同じ実行ファイルや設定ファイルを複数の管理ツールで所有しない。

## 新規Macのbootstrap

1. Determinate Nixをインストールする。
2. Homebrewを公式installerでインストールする。
3. chezmoiを適用する。
4. nix-darwinを適用する。
5. 必要なプロジェクトで`mise install`を実行する。

```sh
nix run nixpkgs#chezmoi -- init --apply samemaru999
sudo nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- \
  switch --flake "$HOME/.config/nix#current"
```

`homebrew.onActivation.cleanup`は、Homebrewの未宣言packageをすべて棚卸しするまで`"none"`を維持する。
