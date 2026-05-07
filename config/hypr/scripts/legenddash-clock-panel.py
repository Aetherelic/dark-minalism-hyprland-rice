#!/usr/bin/env python3
import os
import time
import datetime
import shutil

RESET = "\033[0m"
HIDE = "\033[?25l"

TEXT = "\033[38;2;215;219;210m"
MUTED = "\033[38;2;139;152;146m"
ACCENT = "\033[38;2;157;182;173m"
ACCENT2 = "\033[38;2;195;204;184m"
DIM = "\033[38;2;95;111;107m"

DIGITS = {
    "0": ["  ██████  ", " ██    ██ ", " ██    ██ ", " ██    ██ ", "  ██████  "],
    "1": ["    ██    ", "  ████    ", "    ██    ", "    ██    ", "  ██████  "],
    "2": ["  ██████  ", "       ██ ", "  ██████  ", " ██       ", " ████████ "],
    "3": [" ███████  ", "       ██ ", "   █████  ", "       ██ ", " ███████  "],
    "4": [" ██   ██  ", " ██   ██  ", " ████████ ", "      ██  ", "      ██  "],
    "5": [" ████████ ", " ██       ", " ███████  ", "       ██ ", " ███████  "],
    "6": ["  ██████  ", " ██       ", " ███████  ", " ██    ██ ", "  ██████  "],
    "7": [" ████████ ", "      ██  ", "     ██   ", "    ██    ", "   ██     "],
    "8": ["  ██████  ", " ██    ██ ", "  ██████  ", " ██    ██ ", "  ██████  "],
    "9": ["  ██████  ", " ██    ██ ", "  ███████ ", "       ██ ", "  ██████  "],
    ":": ["          ", "    ██    ", "          ", "    ██    ", "          "],
    " ": ["          ", "          ", "          ", "          ", "          "],
}

def visible_len(s):
    import re
    return len(re.sub(r"\033\[[0-9;]*m", "", s))

def center(s, width):
    pad = max(0, (width - visible_len(s)) // 2)
    return " " * pad + s

print(HIDE, end="", flush=True)

while True:
    cols, rows = shutil.get_terminal_size((90, 28))
    now = datetime.datetime.now()

    colon = ":" if now.second % 2 == 0 else " "
    clock = now.strftime("%H") + colon + now.strftime("%M")
    date = now.strftime("%A, %d %B")
    iso = now.strftime("%Y.%m.%d")

    rendered = [""] * 5
    for ch in clock:
        glyph = DIGITS.get(ch, DIGITS[" "])
        for i in range(5):
            rendered[i] += glyph[i] + " "

    os.system("clear")
    print("\n" * 3, end="")

    print(center(f"{DIM}╭──────────────────────────────╮{RESET}", cols))
    print(center(f"{MUTED}     premium unixporn build     {RESET}", cols))
    print(center(f"{DIM}╰──────────────────────────────╯{RESET}", cols))
    print()

    for line in rendered:
        print(center(f"{ACCENT2}{line}{RESET}", cols))

    print()
    print(center(f"{TEXT}{date}{RESET}", cols))
    print(center(f"{MUTED}{iso}{RESET}", cols))
    time.sleep(1)
