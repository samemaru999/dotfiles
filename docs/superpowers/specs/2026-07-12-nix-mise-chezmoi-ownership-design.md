# Nix・mise・chezmoi 所有権整理 Design

## 目的

Nixを常設CLIとmacOS構成、HomebrewをGUIアプリ、chezmoiをユーザー設定、miseを開発ランタイムの唯一の管理元にする。

## 設計

- Determinate Nix固有設定は `determinateNix.customSettings` のみで管理し、追加キャッシュには `extra-*` を使う。
- Homebrewのtap trustは生成Brewfileで宣言し、trust JSONを直接操作しない。
- ユーザー名とhomeは `config.system.primaryUser` と `config.system.primaryUserHome` から参照する。
- Sketchybarのバイナリ・依存・フォントはNix、設定ファイルはchezmoiが管理する。
- mise本体はNixとし、login・非interactive login shellではshim activation、interactive shellでは通常activationを使う。
- Homebrewの宣言棚卸しが終わるまで `cleanup = "none"` を維持する。
- `mas`は用途が未確認のため今回は維持する。

## 検証

- `chezmoi execute-template`でテンプレート展開が成功する。
- 展開先で`nix flake check --no-build`が成功する。
- 適用後のNix daemon設定が新しいnix-community鍵と追加キャッシュを含む。
- `command -v mise`とmise shimがNix提供のmiseを指す。
- login shellではshimが有効になり、interactive shellでは通常activationがshimをPATHから除去する。
- Homebrewから削除するCLIはすべてNixのsystem profileに存在することを事前確認する。
