#!/usr/bin/env python3
import math, shutil, sys, time

RESET = "\033[0m"
HIDE = "\033[?25l"
AQUA = "\033[38;2;148;226;213m"
GREEN = "\033[38;2;166;227;161m"
BLUE = "\033[38;2;137;180;250m"
DIM = "\033[38;2;65;90;90m"

print(HIDE, end="")
sys.stdout.flush()

t = 0.0
while True:
    cols, rows = shutil.get_terminal_size((100, 8))
    cols = max(50, cols - 8)
    rows = max(6, rows - 3)

    print("\033[H\033[2J", end="")
    print()

    title = "signal"
    print(" " * max(0, (cols - len(title)) // 2) + DIM + title + RESET)
    print()

    mid = rows // 2
    for y in range(rows):
        line = ""
        for x in range(cols):
            wave = mid + int(math.sin((x * 0.12) + t) * 1.6)
            if y == wave:
                if x % 7 == 0:
                    line += GREEN + "✦" + RESET
                elif x % 3 == 0:
                    line += AQUA + "·" + RESET
                else:
                    line += BLUE + "─" + RESET
            else:
                line += " "
        print("    " + line)

    t += 0.28
    time.sleep(0.08)
