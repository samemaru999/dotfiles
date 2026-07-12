#!/usr/bin/env bash

if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused 2>/dev/null)"
fi

if [ -n "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" label="$FOCUSED_WORKSPACE"
fi
