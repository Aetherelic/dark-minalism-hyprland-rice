#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFilter
import random, math
from pathlib import Path

random.seed(804)

OUT = Path.home() / "Pictures" / "Wallpapers"
OUT.mkdir(parents=True, exist_ok=True)

palette = {
    "bg": (8, 13, 16),
    "bg2": (12, 20, 23),
    "panel": (15, 26, 29),
    "sage": (157, 182, 173),
    "aqua": (127, 166, 162),
    "cream": (195, 204, 184),
    "rose": (185, 130, 141),
}

def make_wallpaper(size, path, variant=0):
    W, H = size
    sw, sh = W // 4, H // 4

    img = Image.new("RGB", (sw, sh), palette["bg"])
    px = img.load()

    for y in range(sh):
        for x in range(sw):
            nx = x / sw
            ny = y / sh

            # premium dark diagonal gradient
            v = (nx * 0.45 + ny * 0.55)
            wave = math.sin((nx * 7.5) + variant) * 0.025 + math.cos((ny * 6.0) + variant) * 0.025
            v = max(0, min(1, v + wave))

            r = int(palette["bg"][0] * (1 - v) + palette["bg2"][0] * v)
            g = int(palette["bg"][1] * (1 - v) + palette["bg2"][1] * v)
            b = int(palette["bg"][2] * (1 - v) + palette["bg2"][2] * v)

            # slight noise, very restrained
            n = random.randint(-4, 4)
            px[x, y] = (max(0, r+n), max(0, g+n), max(0, b+n))

    img = img.convert("RGBA")

    # soft glow fields
    overlay = Image.new("RGBA", (sw, sh), (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay, "RGBA")

    glows = [
        (0.18, 0.22, 0.55, palette["sage"], 34),
        (0.82, 0.16, 0.50, palette["aqua"], 28),
        (0.70, 0.82, 0.65, palette["cream"], 22),
        (0.22, 0.78, 0.42, palette["rose"], 14),
    ]

    for gx, gy, radius, color, alpha in glows:
        cx, cy = int(sw * gx), int(sh * gy)
        rx, ry = int(sw * radius), int(sh * radius * 0.65)
        draw.ellipse(
            (cx-rx, cy-ry, cx+rx, cy+ry),
            fill=(color[0], color[1], color[2], alpha)
        )

    overlay = overlay.filter(ImageFilter.GaussianBlur(48))
    img = Image.alpha_composite(img, overlay)

    # subtle contour lines / unixporn texture
    lines = Image.new("RGBA", (sw, sh), (0, 0, 0, 0))
    d = ImageDraw.Draw(lines, "RGBA")

    for i in range(18):
        y = int(sh * (0.15 + i * 0.045))
        points = []
        for x in range(-20, sw + 20, 8):
            yy = y + int(math.sin((x * 0.025) + i + variant) * 7)
            points.append((x, yy))
        colour = palette["sage"] if i % 3 else palette["aqua"]
        d.line(points, fill=(colour[0], colour[1], colour[2], 18), width=1)

    lines = lines.filter(ImageFilter.GaussianBlur(0.4))
    img = Image.alpha_composite(img, lines)

    # tiny stars/noise flecks
    flecks = Image.new("RGBA", (sw, sh), (0, 0, 0, 0))
    d = ImageDraw.Draw(flecks, "RGBA")
    for _ in range(420):
        x = random.randrange(sw)
        y = random.randrange(sh)
        a = random.randrange(12, 42)
        col = random.choice([palette["sage"], palette["aqua"], palette["cream"]])
        d.point((x, y), fill=(col[0], col[1], col[2], a))

    img = Image.alpha_composite(img, flecks)
    img = img.convert("RGB").resize((W, H), Image.Resampling.LANCZOS)

    img.save(path)
    print(path)

make_wallpaper((2560, 1440), OUT / "premium-unixporn-main.png", 0)
make_wallpaper((1920, 1080), OUT / "premium-unixporn-side.png", 2)
