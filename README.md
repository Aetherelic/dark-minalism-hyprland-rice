cd ~/premium-unixporn-hyprland-rice || exit 1

cat > README.md <<'EOF'
# Premium Unixporn Hyprland Rice

A dark, premium, r/unixporn-inspired Hyprland rice built on Nobara/Fedora-based Linux.

This setup is designed around a cohesive charcoal / sage / teal / ivory visual language with glassy panels, smooth animations, a dynamic-island Waybar, custom dashboard widgets, a premium Rofi launcher, custom power menu, lock screen, rice control menus, terminal flex tools, and a fully custom `ricefetch`.

---

## Preview

Add screenshots here:

```text
screenshots/
```

Recommended screenshot flow:

```text
SUPER + SHIFT + S  -> Showcase Mode
PRINT              -> Full screenshot
SHIFT + PRINT      -> Area screenshot
SUPER + PRINT      -> Edit screenshot
```

---

## Main Features

### Hyprland Desktop

- Premium Hyprland configuration
- Smooth Apple-like window animations
- Rounded windows
- Glass blur and subtle opacity
- Refined gaps and borders
- Floating utility app rules
- Game-safe rules for Steam/game windows
- Final glass polish layer
- Workspace layout scripting
- Main monitor and side monitor setup
- Showcase mode for clean screenshots

### Waybar

- Premium floating pill-style Waybar
- Dynamic island on the main monitor
- Music-aware dynamic island
- Active-window fallback text
- Idle fallback text
- Clean workspace pills
- Polished right-side modules
- Matching charcoal/sage/ivory styling
- Dynamic island removed from the second monitor

### Dashboard

- Custom Kitty-based dashboard
- Dashboard pinned to side monitor workspace
- Custom fetch/system info panel
- Cava audio visualizer panel
- Animated bonsai decoration
- Dashboard launcher and toggle scripts
- Premium glass styling
- Monitor-aware placement scripts

### Rofi

- Premium app launcher
- Dark glassmorphism theme
- Muted sage selection highlight
- Fuzzy search
- Icon support
- Used for app launcher, rice control center, and keybind HUD

### SwayNC

- Premium notification center styling
- Dark glass control center
- Muted sage borders
- Styled notification cards
- DND widget styling
- MPRIS/music widget styling

### Power Menu

- Custom Eww power menu
- Bound to `SUPER + L`
- Premium glass panel
- User/status card
- Lock, logout, reboot, sleep, close, and power actions
- Rose accent for shutdown/danger action
- Matching sage button styling

### Hyprlock

- Premium lock screen
- Blurred screenshot background
- Large clean clock
- Date and status labels
- Rounded password field
- Matching dark/sage palette
- Bound to `SUPER + SHIFT + L`

### Hypridle

- Automatic idle behaviour
- Idle notification
- Auto-lock with Hyprlock
- DPMS monitor-off after timeout
- Resume wakes monitors cleanly
- Locks before sleep

### Screenshot Workflow

- Full screenshot
- Area screenshot
- Copy area screenshot to clipboard
- Edit screenshot with Swappy
- Screenshot scripts included

### Custom Terminal Setup

- Premium Kitty theme
- Custom `ricefetch`
- Custom ASCII support from `~/.config/ricefetch/ascii.txt`
- Matching btop theme
- Matching Cava theme
- Terminal aliases
- `terminal-flex` command
- `SUPER + SHIFT + ENTER` terminal flex bind

### Rice Tools

Included local commands:

| Command | Purpose |
|---|---|
| `ricefetch` | Custom premium terminal system card |
| `rice-control` | Rofi-based rice control center |
| `rice-help` | Rofi-based keybind HUD |
| `terminal-flex` | Opens ricefetch, then btop |

---

## Rice Control Center

Bound to:

```text
SUPER + CTRL + SPACE
```

Menu actions:

```text
Showcase Mode
Toggle Dashboard
Restart Waybar
Toggle SwayNC
Refresh Wallpaper
Screenshot Area
Open Config Folder
Reload Hyprland
Lock Screen
Power Menu
```

---

## Keybind HUD

Bound to:

```text
SUPER + F1
```

The keybind HUD shows important binds and can launch useful actions directly through Rofi.

---

## Keybinds

| Bind | Action |
|---|---|
| `SUPER + ENTER` | Open Kitty |
| `SUPER + SHIFT + ENTER` | Terminal Flex |
| `ALT + SPACE` | App Launcher |
| `SUPER + SPACE` | App Launcher |
| `SUPER + L` | Power Menu |
| `SUPER + SHIFT + L` | Lock Screen |
| `SUPER + SHIFT + S` | Showcase Mode |
| `SUPER + CTRL + SPACE` | Rice Control Center |
| `SUPER + F1` | Keybind HUD |
| `PRINT` | Full Screenshot |
| `SHIFT + PRINT` | Area Screenshot |
| `CTRL + PRINT` | Copy Area Screenshot |
| `SUPER + PRINT` | Edit Screenshot |
| `SUPER + M` | Exit Hyprland |
| `SUPER + Q` | Close focused window, depending on your final local bind setup |

---

## Monitor Layout

This rice was built around this layout:

```text
DP-2 = main monitor
DP-1 = side monitor
```

Check your own monitor names with:

```bash
hyprctl monitors
```

Files you may need to edit if your monitor names differ:

```text
config/hypr/hyprland.conf
config/hypr/scripts/wallpaper.sh
config/hypr/scripts/legenddash-launch.sh
config/hypr/scripts/premium-showcase.sh
config/waybar/config.jsonc
```

---

## Dependencies

This setup was built and tested on Nobara/Fedora-based Linux.

Install the main packages:

```bash
sudo dnf install -y \
  hyprland \
  hyprlock \
  hypridle \
  waybar \
  rofi \
  kitty \
  jq \
  swww \
  eww \
  cava \
  btop \
  fastfetch \
  pavucontrol \
  playerctl \
  brightnessctl \
  network-manager-applet \
  blueman \
  SwayNotificationCenter \
  grim \
  slurp \
  swappy \
  wl-clipboard \
  libnotify \
  papirus-icon-theme \
  breeze-cursor-theme \
  adw-gtk3-theme \
  gnome-themes-extra \
  qt5ct \
  qt6ct \
  kvantum \
  nwg-look \
  eza \
  bat \
  fzf \
  zoxide \
  starship
```

Some package names may differ slightly depending on your Fedora/Nobara version or enabled repositories.

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/YOUR_USERNAME/premium-unixporn-hyprland-rice.git
cd premium-unixporn-hyprland-rice
```

Replace `YOUR_USERNAME` with your GitHub username.

---

### 2. Back up your current configs

```bash
mkdir -p ~/.config/rice-backup-$(date +%F-%H%M%S)

BACKUP_DIR="$(ls -td ~/.config/rice-backup-* | head -n1)"

cp -a ~/.config/hypr "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/waybar "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/rofi "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/swaync "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/eww-legend-power "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/kitty "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/dashboard "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/ricefetch "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/btop "$BACKUP_DIR/" 2>/dev/null || true
cp -a ~/.config/cava "$BACKUP_DIR/" 2>/dev/null || true

echo "Backup saved to:"
echo "$BACKUP_DIR"
```

---

### 3. Copy configs

```bash
mkdir -p ~/.config ~/.local/bin ~/Pictures/Wallpapers

cp -a config/hypr ~/.config/
cp -a config/waybar ~/.config/
cp -a config/rofi ~/.config/
cp -a config/swaync ~/.config/
cp -a config/eww-legend-power ~/.config/
cp -a config/kitty ~/.config/
cp -a config/dashboard ~/.config/
cp -a config/ricefetch ~/.config/
cp -a config/btop ~/.config/
cp -a config/cava ~/.config/

cp -a config/gtk-3.0 ~/.config/ 2>/dev/null || true
cp -a config/gtk-4.0 ~/.config/ 2>/dev/null || true
cp -a config/qt5ct ~/.config/ 2>/dev/null || true
cp -a config/qt6ct ~/.config/ 2>/dev/null || true

cp -a local-bin/* ~/.local/bin/
cp -a wallpapers/* ~/Pictures/Wallpapers/ 2>/dev/null || true

chmod +x ~/.local/bin/ricefetch ~/.local/bin/rice-control ~/.local/bin/rice-help ~/.local/bin/terminal-flex 2>/dev/null || true
chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true
chmod +x ~/.config/waybar/scripts/*.sh 2>/dev/null || true
chmod +x ~/.config/eww-legend-power/scripts/*.sh 2>/dev/null || true
```

---

### 4. Apply wallpapers

```bash
~/.config/hypr/scripts/wallpaper.sh
```

This rice expects wallpapers at:

```text
~/Pictures/Wallpapers/maindisplay.jpg
~/Pictures/Wallpapers/sidedisplay.jpg
```

Your final local setup may use `sidedisplay.jpg` on both monitors depending on your `wallpaper.sh`.

---

### 5. Reload Hyprland

```bash
hyprctl reload
```

Check for errors:

```bash
hyprctl configerrors
```

---

### 6. Start core services manually

```bash
pkill waybar 2>/dev/null || true
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css >/tmp/waybar.log 2>&1 &

pkill swaync 2>/dev/null || true
swaync >/tmp/swaync.log 2>&1 &

pkill hypridle 2>/dev/null || true
hypridle >/tmp/hypridle.log 2>&1 &

pgrep -x swww-daemon >/dev/null || swww-daemon --format xrgb >/tmp/swww-daemon.log 2>&1 &
```

---

### 7. Test rice tools

```bash
ricefetch
rice-control
rice-help
terminal-flex
```

Or directly:

```bash
~/.local/bin/ricefetch
~/.local/bin/rice-control
~/.local/bin/rice-help
~/.local/bin/terminal-flex
```

---

## Terminal Setup

Recommended Bash aliases:

```bash
cat >> ~/.bashrc <<'EOF'

# Premium Unixporn terminal helpers
alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias cat='bat --style=plain --paging=never'
alias ff='$HOME/.local/bin/ricefetch'
alias fetch='$HOME/.local/bin/ricefetch'
alias top='btop'
alias viz='cava'
alias musicviz='cava'
alias cls='clear'
EOF

source ~/.bashrc
```

Recommended Fish aliases:

```bash
mkdir -p ~/.config/fish/conf.d

cat > ~/.config/fish/conf.d/premium-unixporn.fish <<'EOF'
alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias cat='bat --style=plain --paging=never'
alias ff='$HOME/.local/bin/ricefetch'
alias fetch='$HOME/.local/bin/ricefetch'
alias top='btop'
alias viz='cava'
alias musicviz='cava'
alias cls='clear'
EOF
```

---

## Custom Ricefetch

The custom terminal card uses:

```text
~/.local/bin/ricefetch
~/.config/ricefetch/ascii.txt
```

To change the ASCII:

```bash
nano ~/.config/ricefetch/ascii.txt
```

Then run:

```bash
ricefetch
```

---

## Wallpaper Notes

Recommended wallpaper style:

```text
dark topographic contour wallpaper
charcoal sage green abstract wallpaper
dark teal topography wallpaper
minimal dark contour map wallpaper
```

Avoid wallpapers that are too bright, too busy, or full of strong red/purple tones unless you also adjust the palette.

---

## File Structure

```text
config/
  hypr/
  waybar/
  rofi/
  swaync/
  eww-legend-power/
  kitty/
  dashboard/
  ricefetch/
  btop/
  cava/
  gtk-3.0/
  gtk-4.0/
  qt5ct/
  qt6ct/

local-bin/
  ricefetch
  rice-control
  rice-help
  terminal-flex

wallpapers/
  maindisplay.jpg
  sidedisplay.jpg

docs/
  nobara-packages.txt
```

---

## Important Scripts

### Hyprland

```text
config/hypr/scripts/wallpaper.sh
config/hypr/scripts/premium-showcase.sh
config/hypr/scripts/premium-screenshot.sh
config/hypr/scripts/legenddash-launch.sh
config/hypr/scripts/legenddash-toggle.sh
config/hypr/scripts/legend-eww-powermenu.sh
```

### Waybar

```text
config/waybar/scripts/dynamic-island.sh
```

### Local tools

```text
local-bin/ricefetch
local-bin/rice-control
local-bin/rice-help
local-bin/terminal-flex
```

---

## Troubleshooting

### Hyprland config errors

```bash
hyprctl configerrors
```

### Restart Waybar

```bash
pkill waybar 2>/dev/null || true
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css >/tmp/waybar.log 2>&1 &
tail -n 80 /tmp/waybar.log
```

### Restart SwayNC

```bash
pkill swaync 2>/dev/null || true
swaync >/tmp/swaync.log 2>&1 &
tail -n 80 /tmp/swaync.log
```

### Restart Hypridle

```bash
pkill hypridle 2>/dev/null || true
hypridle >/tmp/hypridle.log 2>&1 &
tail -n 80 /tmp/hypridle.log
```

### Test wallpapers

```bash
~/.config/hypr/scripts/wallpaper.sh
```

### Test dashboard

```bash
~/.config/hypr/scripts/legenddash-launch.sh
```

### Test dynamic island output

```bash
~/.config/waybar/scripts/dynamic-island.sh
```

---

## Notes

This rice was made for my personal Nobara Hyprland setup.

It is not a universal installer. You may need to adjust:

- monitor names
- GPU-specific settings
- package names
- wallpaper paths
- font availability
- dashboard placement
- Waybar output blocks

---

## Recommended Fonts

Install a Nerd Font before using this rice.

Recommended:

```text
JetBrainsMono Nerd Font
Symbols Nerd Font
```

---

## Credits

Built with:

- Hyprland
- Waybar
- Rofi
- Kitty
- SwayNC
- Eww
- Hyprlock
- Hypridle
- Cava
- btop
- swww
- grim/slurp/swappy
- Papirus icons

---

## License

Use, remix, and modify however you want.

If you publish a modified version, credit is appreciated but not required.

EOF
