#!/bin/bash
CONFIG_FILE="$HOME/.config/hypr/default/monitors.conf"
INTERNAL="eDP-1"

# 检测外接显示器是否连接
EXTERNAL=$(hyprctl monitors | grep -o "DP-[2-3]")

if [ -z "$EXTERNAL" ]; then
  # 外接显示器未连接时，强制启用内置显示器
  echo "monitor=$INTERNAL,2240x1400@60,0x0,1.33" > "$CONFIG_FILE"
else
  # 切换内置显示器状态
  if grep -q "$INTERNAL,disable" "$CONFIG_FILE"; then
    # 当前关闭 → 重新启用
    sed -i "s/monitor=$INTERNAL,disable/monitor=$INTERNAL,2240x1400@60,2560x0,1.33/" "$CONFIG_FILE"
  else
    # 当前启用 → 关闭
    sed -i "s/monitor=$INTERNAL.*/monitor=$INTERNAL,disable/" "$CONFIG_FILE"
  fi
fi


