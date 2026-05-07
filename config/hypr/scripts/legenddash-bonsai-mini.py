#!/usr/bin/env python3
import os
import time
import shutil

RESET = "\033[0m"
HIDE  = "\033[?25l"

LEAF1 = "\033[38;2;188;198;150m"
LEAF2 = "\033[38;2;143;168;154m"
TRUNK = "\033[38;2;205;214;200m"
POT   = "\033[38;2;120;136;128m"
DIM   = "\033[38;2;90;105;98m"

frames = [
[
"          .:.          ",
"        .:***:.        ",
"       .:**|**:.       ",
"         .\\|/.         ",
"          \\|/          ",
"           |           ",
"         \\ | /         ",
"          \\|/          ",
"           |           ",
"        ___|___        ",
"       /       \\       ",
"      /_________\\      ",
],
[
"          .:*          ",
"        .:***:.        ",
"       .:**|**:.       ",
"         .\\|/.         ",
"          \\|/          ",
"           |           ",
"         \\ | /         ",
"          \\|/          ",
"           |           ",
"        ___|___        ",
"       /       \\       ",
"      /_________\\      ",
],
[
"          .:.          ",
"        .:***:.        ",
"       .:**|**:.       ",
"         .\\|/.         ",
"          \\|/          ",
"           |           ",
"         \\ | /         ",
"          \\|/          ",
"           |           ",
"        ___|___        ",
"       /       \\       ",
"      /_________\\      ",
],
[
"          *:.          ",
"        .:***:.        ",
"       .:**|**:.       ",
"         .\\|/.         ",
"          \\|/          ",
"           |           ",
"         \\ | /         ",
"          \\|/          ",
"           |           ",
"        ___|___        ",
"       /       \\       ",
"      /_________\\      ",
]
]

print(HIDE, end="", flush=True)

while True:
    cols, rows = shutil.get_terminal_size((28, 16))
    for art in frames:
        os.system("clear")
        top_pad = max(0, (rows - len(art)) // 2 - 1)
        side_pad = max(0, (cols - len(art[0])) // 2)

        print("\n" * top_pad, end="")
        for line in art:
            rendered = ""
            for ch in line:
                if ch in [".", ":", "*"]:
                    rendered += LEAF1 + ch + RESET
                elif ch in ["|", "/", "\\"]:
                    rendered += TRUNK + ch + RESET
                elif ch in ["_", "(", ")", "[", "]"]:
                    rendered += POT + ch + RESET
                else:
                    rendered += DIM + ch + RESET if ch == " " else ch
            print(" " * side_pad + rendered)

        time.sleep(0.45)
