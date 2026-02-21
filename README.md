# NeonPink GNOME Themes

Custom GNOME Shell and GTK themes with pink neon cyberpunk aesthetic.

## Location
- **GnomeShell themes**: `/home/jnxlr/PRO/ART/DES/themes/GnomeShell/`
- **GTK themes**: `/home/jnxlr/PRO/ART/DES/themes/GTK/`
- **Symlinks**: `~/.themes/` (for GNOME compatibility)

## Variants

### NeonPink (Static)
Static neon glow effects - **Wayland compatible**.
- Location: `GnomeShell/NeonPink/`
- Features: Static pink neon borders, glowing menus, mist gradient backgrounds

### NeonPink_Animated
Animated neon flicker and mist drift effects.
- Location: `GnomeShell/NeonPink_Animated/`
- Features: Pulsing neon borders, color-shifting, animated mist background
- **Note**: May not work on GNOME Wayland (keyframe animations)

## Usage

### Activate Shell Theme
```bash
# Static version (current)
gsettings set org.gnome.shell.extensions.user-theme name "NeonPink"

# Animated version
gsettings set org.gnome.shell.extensions.user-theme name "NeonPink_Animated"
```

### Reload GNOME Shell
- **X11**: Press `Alt+F2`, type `r`, press Enter
- **Wayland**: Log out and back in

### GTK Theme for Apps
The GTK 4.0 theme is automatically included in both variants for VS Code and other GTK apps.

## Customization
Edit the CSS files directly:
- Shell: `gnome-shell/gnome-shell.css`
- GTK: `gtk-4.0/gtk.css`

Changes take effect after reloading GNOME Shell.

---
Created: 2026-02-21
