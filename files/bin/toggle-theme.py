#!/usr/bin/env python
import glob
import sys
import os
import subprocess

KITTY_THEMES = {
    'dark': '~/.config/kitty/rose-pine.conf',
    'light': '~/.config/kitty/rose-pine-dawn.conf',
}


def determine_theme():
    (status, _) = subprocess.getstatusoutput("defaults read -g AppleInterfaceStyle")

    if status == 0:
        return 'dark'
    else:
        return 'light'


def toggle_theme():
    (status, _) = subprocess.getstatusoutput("""
       osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
    """)

    return status == 0


def set_kitty_theme(theme):
    files = glob.iglob("/tmp/kitty-ctrl-*")
    theme_path = KITTY_THEMES[theme]

    for file in files:
        os.system(f"kitty @ --to unix:{file} set-colors -a {theme_path}")


def bail(msg):
    print(msg, file=sys.stderr)
    sys.exit(1)


if __name__ == '__main__':
    success = toggle_theme()

    if not success:
        bail("Failed to toggle theme")

    theme = determine_theme()

    set_kitty_theme(theme)



