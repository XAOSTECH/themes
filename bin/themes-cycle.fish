#!/usr/bin/env fish
# ═══════════════════════════════════════════════════════════════════════════════
# themes-cycle.fish — fish variant (scaffold) of the palette cycler
# ═══════════════════════════════════════════════════════════════════════════════
# Scaffold target for fish users (the maintainer uses bash/zsh — see
# themes-cycle.sh). Mirrors the POSIX core: pick a pre-generated palette at
# random and point kitty + starship at it, with no pastel and no toml mutation.
#
# Source from ~/.config/fish/config.fish:
#   source /path/to/themes/bin/themes-cycle.fish
#
# Configuration (optional):
#   THEMES_DIR   Base directory holding palettes/ and fallback/.
#                Default: $HOME/.config/themes
# ═══════════════════════════════════════════════════════════════════════════════

set -q THEMES_DIR; or set -gx THEMES_DIR "$HOME/.config/themes"

# Fixed fallback profile — used when no palette set is installed.
set -g THEMES_FALLBACK_BG '#0a0512'
set -g THEMES_FALLBACK_SURFACE '#100e23'
set -g THEMES_FALLBACK_ACCENT '#ff00aa'

function _themes_apply --argument-names choice
    test -d "$choice"; or return 1

    # kitty: atomic symlink swap of current-theme.conf.
    if test -d "$HOME/.config/kitty"; and test -f "$choice/kitty.conf"
        set -l tmp "$HOME/.config/kitty/.current-theme.$fish_pid.tmp"
        if ln -sf -- "$choice/kitty.conf" "$tmp" 2>/dev/null
            mv -f -- "$tmp" "$HOME/.config/kitty/current-theme.conf" 2>/dev/null
            or rm -f -- "$tmp" 2>/dev/null
        end
    end

    # starship: switch via environment override, no toml mutation.
    if test -f "$choice/starship.toml"
        set -gx STARSHIP_CONFIG "$choice/starship.toml"
    end

    set -gx THEMES_ACTIVE_PALETTE (basename "$choice")
    return 0
end

function themes_cycle
    set -l dirs
    for d in "$THEMES_DIR"/palettes/*/
        set -a dirs $d
    end

    if test (count $dirs) -gt 0
        set -l idx (random 1 (count $dirs))
        if _themes_apply "$dirs[$idx]"
            return 0
        end
    end

    if _themes_apply "$THEMES_DIR/fallback"
        return 0
    end

    set -gx THEMES_ACTIVE_PALETTE fallback
    set -gx THEMES_FALLBACK true
end

themes_cycle
