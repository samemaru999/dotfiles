# Sketchybar Calendar Display Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Sketchybar右側の4分割calendarを、icon付きの日付・時刻の2アイテムへ変更する。

**Architecture:** `icons.lua`が表示方式ごとのcalendar/clock glyphを提供し、`items/calendar.lua`がSbarLuaでdate/time itemを生成する。shell scriptを増やさず、`os.date`とSketchybar eventで表示を更新する。

**Tech Stack:** Lua、SbarLua、Sketchybar、chezmoi

## Global Constraints

- 日付は`%m/%d %a`、時刻は`%H:%M`を使用する。
- 日付は60秒、時刻は30秒ごとに更新する。
- 既存のTokyo Night背景、枠線、右側paddingを維持する。
- Sketchybar全体をGitへ追加せず、対象ファイルのみ変更する。

---

### Task 1: Calendar/clock icons

**Files:**
- Modify: `dot_config/sketchybar/icons.lua`
- Test: shell assertion against `dot_config/sketchybar/icons.lua`

**Interfaces:**
- Produces: `icons.calendar` and `icons.clock` strings for the selected icon family.

- [ ] **Step 1: Verify the icon keys are currently missing**

Run: `rg '^\s*(calendar|clock)\s*=' dot_config/sketchybar/icons.lua`
Expected: no matches.

- [ ] **Step 2: Add icons for both families**

Add `calendar = "􀉉"` and `clock = "􀐫"` to `sf_symbols`, and `calendar = "󰃭"` and `clock = "󰥔"` to `nerdfont`.

- [ ] **Step 3: Verify both icon families expose the keys**

Run: `rg '^\s*(calendar|clock)\s*=' dot_config/sketchybar/icons.lua`
Expected: four matches.

### Task 2: Two-item date/time display

**Files:**
- Modify: `dot_config/sketchybar/items/calendar.lua`
- Test: Lua syntax and shell assertions against `dot_config/sketchybar/items/calendar.lua`

**Interfaces:**
- Consumes: `icons.calendar`, `icons.clock`, Tokyo Night colors, font settings.
- Produces: Sketchybar items `calendar.date` and `calendar.time`.

- [ ] **Step 1: Verify the desired item names and formats are currently missing**

Run: `rg 'calendar\.(date|time)|%m/%d %a' dot_config/sketchybar/items/calendar.lua`
Expected: no matches.

- [ ] **Step 2: Replace the four calendar items**

Create `calendar.date` and `calendar.time`, set their icon/color/label/font/padding/update frequency, group them in the existing bracket style, and subscribe both to `forced`, `routine`, and `system_woke`.

- [ ] **Step 3: Verify syntax and required properties**

Run: `luac -p dot_config/sketchybar/icons.lua dot_config/sketchybar/items/calendar.lua`
Expected: exit 0.

Run: `rg 'update_freq = (60|30)|%m/%d %a|%H:%M' dot_config/sketchybar/items/calendar.lua`
Expected: four matches.

### Task 3: Apply and runtime verification

**Files:**
- Apply: `~/.config/sketchybar/icons.lua`
- Apply: `~/.config/sketchybar/items/calendar.lua`

**Interfaces:**
- Consumes: chezmoi source files from Tasks 1 and 2.
- Produces: reloaded Sketchybar date/time items.

- [ ] **Step 1: Apply only the changed files**

Run: `chezmoi apply --force ~/.config/sketchybar/icons.lua ~/.config/sketchybar/items/calendar.lua`
Expected: exit 0.

- [ ] **Step 2: Reload Sketchybar**

Run: `sketchybar --reload`
Expected: exit 0.

- [ ] **Step 3: Verify generated item properties and daemon state**

Run: execute `items/calendar.lua` with a minimal SbarLua mock, then inspect `launchctl print gui/$(id -u)/org.nixos.sketchybar`.
Expected: both items have non-empty icons and labels, and the launchd service remains `state = running`.
