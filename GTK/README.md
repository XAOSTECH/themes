# NeonPink GNOME Themes

Custom GNOME Shell and GTK themes with soft off-pink pastel aesthetic, featuring ethereal glows and increased transparency.

## Colour Palette
Generated using `pastel` for beautiful, harmonious colours:
- **Soft Pink**: #ffb3d9, #f8b0d8, #f1add8, #eaaad7
- **Light Accents**: #f1cfe9, #e3a8d7
- **Medium Backgrounds**: #b15dbc (177, 93, 188)
- **Deep Tones**: #76347f (118, 52, 127)

## Location
- **GnomeShell themes**: `/home/jnxlr/PRO/ART/DES/themes/GnomeShell/`
- **GTK themes**: `/home/jnxlr/PRO/ART/DES/themes/GTK/`
- **Symlinks**: `~/.themes/` (for GNOME compatibility)

## Variants

### NeonPink (Static)
Soft pastel glow effects with high transparency - **Wayland compatible**.
- Location: `GnomeShell/NeonPink/`
- Features: 
  - Soft off-pink pastel colours throughout
  - Enhanced transparency (30-50% on most elements)
  - Static glowing borders and shadows
  - Ethereal gradient backgrounds
  - Comprehensive styling for all GNOME components:
    - Workspace switcher & thumbnails
    - Overview & search
    - Quick settings & system menu
    - Calendar & notifications
    - Message lists & banners
    - Buttons, sliders, switches
    - Window picker & app icons
    - Dash/dock
    - OSD & lock screen
    - Tooltips & popovers

### NeonPink_Animated
Gentle pastel glow animations with breathing effects.
- Location: `GnomeShell/NeonPink_Animated/`
- Features: 
  - All features from static version
  - Smooth `pastelGlow` animation (softer than original neon flicker)
  - Gentle `mistDrift` background animation
  - Animated quick toggles, calendar today, workspace indicators
  - **Note**: May not work on GNOME Wayland (keyframe animations)

## Usage

### Activate Shell Theme
```bash
# Static version (recommended for Wayland)
gsettings set org.gnome.shell.extensions.user-theme name "NeonPink"

# Animated version (better on X11)
gsettings set org.gnome.shell.extensions.user-theme name "NeonPink_Animated"
```

### Reload GNOME Shell
- **X11**: Press `Alt+F2`, type `r`, press Enter
- **Wayland**: Log out and back in

### GTK Theme for Apps
The GTK 4.0 theme is automatically included in both variants for VS Code and other GTK apps, featuring:
- Matching off-pink colour scheme
- Increased transparency on windows and popups
- Soft glowing accents on interactive elements
- Pastel highlights for focused elements

## Customisation
Edit the CSS files directly:
- Shell: `gnome-shell/gnome-shell.css`
- GTK: `gtk-4.0/gtk.css`

Changes take effect after reloading GNOME Shell.

## Theme Features
- **High Transparency**: Most elements use 25-50% opacity for ethereal effect
- **Comprehensive Coverage**: Styles for 20+ GNOME Shell components
- **Pastel Colour Science**: Colours generated using `pastel` for optimal harmony
- **Blur Effects**: `backdrop-filter: blur()` for depth and glassmorphism
- **Accessibility**: Maintained readability despite transparency
- **Performance**: Optimised animations (2-3.5s cycles on animated version)

---
Created: 2026-02-21
Updated: 2026-02-21 - Redesigned with pastel colours, increased transparency, and comprehensive component coverage

