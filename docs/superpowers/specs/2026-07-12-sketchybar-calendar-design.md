# Sketchybar Calendar Display Design

## 目的

右側の4分割calendar表示を、icon付きの日付・時刻の2アイテムへ変更する。

## 表示

```text
[ 􀉉 07/12 Sun   􀐫 14:30 ]
```

- 日付: `%m/%d %a`、60秒ごとに更新
- 時刻: `%H:%M`、30秒ごとに更新
- calendar icon: `colors.tn_orange`
- clock icon: `colors.tn_yellow`
- label: `colors.tn_white1`
- 既存のTokyo Night背景、枠線、右側paddingを維持する

## 実装

- `icons.lua`のSF SymbolsとNerd Font両方へ`calendar`と`clock`を追加する。
- `items/calendar.lua`を`calendar.date`と`calendar.time`の2アイテムへ整理する。
- shell scriptではなくSbarLuaの`os.date`とevent subscriptionを使う。
- `routine`、`forced`、`system_woke`で表示を更新する。

## 検証

- Lua構文検査が成功する。
- sourceをchezmoiで適用し、targetとの差分がなくなる。
- SbarLuaのmock実行でdate/time itemのlabel、icon、更新間隔を検査する。
- Sketchybarを再読み込みし、launchd serviceがrunningを維持する。
