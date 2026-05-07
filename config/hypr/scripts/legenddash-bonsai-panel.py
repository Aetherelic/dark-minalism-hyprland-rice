#!/usr/bin/env python3
import os, random, shutil, time, sys

RESET = "\033[0m"
HIDE = "\033[?25l"
DIM = "\033[38;2;80;105;105m"
LEAF1 = "\033[38;2;166;227;161m"
LEAF2 = "\033[38;2;148;226;213m"
LEAF3 = "\033[38;2;137;180;250m"
TRUNK = "\033[38;2;180;190;254m"
POT = "\033[38;2;116;130;130m"
TITLE = "\033[38;2;205;214;244m"

tree = [
"                  ✦        ",
"              .  .:.  .    ",
"          .:  ✧  :|:  ✧  :.",
"        .:✦     \\|/     ✦:.",
"      .:..    -- ✧ --    ..:.",
"          ✦     /|\\     ✦  ",
"                /|\\        ",
"               / | \\       ",
"              /  |  \\      ",
"             /   |   \\     ",
"        ✦   /    |    \\    ",
"           /     |     \\   ",
"          /      |      \\  ",
"        _/       |       \\_",
"       /__       |       __\\",
"          \\__    |    __/  ",
"             \\___|___/     ",
"                 |         ",
"                /|\\        ",
"               /_|_\\       ",
"          ____/_____/____  ",
"         /_______________\\ ",
"             (_)     (_)   ",
]

print(HIDE, end="")
sys.stdout.flush()

frame = 0
while True:
    cols, rows = shutil.get_terminal_size((70, 32))
    os.system("clear")

    top_pad = max(1, (rows - len(tree) - 3) // 2)
    for _ in range(top_pad):
        print()

    title = "bonsai"
    print(" " * max(0, (cols - len(title)) // 2) + TITLE + title + RESET)
    print()

    for line in tree:
        out = ""
        for ch in line:
            if ch in ["✦", "✧", ".", ":"]:
                colour = random.choice([LEAF1, LEAF2, LEAF3, DIM])
                out += colour + ch + RESET
            elif ch in ["/", "\\", "|", "_"]:
                out += TRUNK + ch + RESET
            elif ch in ["(", ")", "[", "]"]:
                out += POT + ch + RESET
            else:
                out += ch

        plain_len = len(line)
        pad = max(0, (cols - plain_len) // 2)
        print(" " * pad + out)

    frame += 1
    time.sleep(0.18)
