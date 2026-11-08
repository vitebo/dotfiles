#!/usr/bin/env bash

# dotfiles: the bar's Light / Dark / System button (see sketchybarrc).
#   appearance_mode.sh                     item script: icon of the current mode
#   appearance_mode.sh light|dark|system   sets the macOS appearance (popup entries)
# "System" is macOS' Auto appearance (light by day, dark by night). macOS has no
# public command for it (AppleScript only turns dark mode on / off), so this calls
# SkyLight's appearance functions, the ones System Settings uses, through JXA. It's
# a private API: if a macOS update breaks it, only this button stops working. The
# bar's colors still follow the appearance (plugins/appearance.sh).

# The mouse left the button and its popup: close the popup.
if [ "$SENDER" = "mouse.exited.global" ]; then
    sketchybar --set appearance_mode popup.drawing=off
    exit 0
fi

# Runs JXA code ($1) with SkyLight's appearance functions bound.
skylight() {
    osascript -l JavaScript -e "
        ObjC.import('Foundation');
        \$.NSBundle.bundleWithPath('/System/Library/PrivateFrameworks/SkyLight.framework').load;
        ObjC.bindFunction('SLSGetAppearanceThemeSwitchesAutomatically', ['bool', []]);
        ObjC.bindFunction('SLSSetAppearanceThemeSwitchesAutomatically', ['void', ['bool']]);
        ObjC.bindFunction('SLSSetAppearanceThemeLegacy', ['void', ['int']]);
        $1"
}

# Prints system, dark or light.
current_mode() {
    if [ "$(skylight '$.SLSGetAppearanceThemeSwitchesAutomatically()')" = "true" ]; then
        echo system
    elif [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]; then
        echo dark
    else
        echo light
    fi
}

case "$1" in
    light)  skylight '$.SLSSetAppearanceThemeSwitchesAutomatically(false); $.SLSSetAppearanceThemeLegacy(0)' ;;
    dark)   skylight '$.SLSSetAppearanceThemeSwitchesAutomatically(false); $.SLSSetAppearanceThemeLegacy(1)' ;;
    system) skylight '$.SLSSetAppearanceThemeSwitchesAutomatically(true)' ;;
esac >/dev/null

if [ -n "$1" ]; then
    # Close the popup and refresh the icon: turning System on or off doesn't change
    # the appearance itself, so no reload would refresh it.
    sketchybar --set appearance_mode popup.drawing=off \
               --trigger appearance_mode_changed
    exit 0
fi

MODE="$(current_mode)"
case "$MODE" in
    light)  ICON=󰖨 ;;  # nf-md-weather_sunny
    dark)   ICON=󰖔 ;;  # nf-md-weather_night
    system) ICON=󰔎 ;;  # nf-md-theme_light_dark
esac

# The icon, and the current mode highlighted in the popup.
args=(--set appearance_mode icon="$ICON")
for mode in light dark system; do
    if [ "$mode" = "$MODE" ]; then
        args+=(--set "appearance_mode.$mode" background.drawing=on)
    else
        args+=(--set "appearance_mode.$mode" background.drawing=off)
    fi
done
sketchybar "${args[@]}"
