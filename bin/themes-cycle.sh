#!/usr/bin/env sh
# ═══════════════════════════════════════════════════════════════════════════════
# themes-cycle.sh — runtime palette cycler for kitty + starship
# ═══════════════════════════════════════════════════════════════════════════════
# Picks a pre-generated palette at random on every new interactive shell and
# points kitty and starship at it. Designed to be sourced from ~/.bashrc or
# ~/.zshrc so that STARSHIP_CONFIG is exported into the shell:
#
#   . /path/to/themes/bin/themes-cycle.sh
#
# Palettes are pre-generated (see ../assets/palettes/, regenerated with tuiGen),
# so this hot path never runs pastel. It performs no destructive disk edits
# (no sed -i): kitty is switched by an atomic symlink swap and starship by an
# environment override, which keeps concurrent shell spawns race-free.
#
# Design mandates honoured:
#   * Sub-15ms: pure shell builtins plus two tiny coreutils calls (ln, mv).
#   * No pastel at launch; no sed -i / destructive edits.
#   * Never blocks or drops stdin/stdout/stderr; never calls exit when sourced.
#   * Falls back to a fixed profile when no palette is available.
#
# Configuration (environment, all optional):
#   THEMES_DIR   Base directory holding palettes/ and fallback/.
#                Default: $HOME/.config/themes
# ═══════════════════════════════════════════════════════════════════════════════

# Fixed fallback profile (background #0a0512, surface #100e23, accent #ff00aa)
# is exported only as a last resort — see themes_cycle below.

# Apply a single palette directory to kitty and starship.
# Usage: _themes_apply <palette-dir>
_themes_apply() {
    local _tc_choice _tc_tmp
    _tc_choice="${1%/}"
    [ -d "$_tc_choice" ] || return 1

    # kitty: atomic symlink swap of current-theme.conf. kitty.conf is expected
    # to carry a permanent `include current-theme.conf`; new windows read it.
    if [ -d "$HOME/.config/kitty" ] && [ -f "$_tc_choice/kitty.conf" ]; then
        _tc_tmp="$HOME/.config/kitty/.current-theme.$$.tmp"
        if ln -sf -- "$_tc_choice/kitty.conf" "$_tc_tmp" 2>/dev/null; then
            mv -f -- "$_tc_tmp" "$HOME/.config/kitty/current-theme.conf" 2>/dev/null \
                || rm -f -- "$_tc_tmp" 2>/dev/null
        fi
    fi

    # starship: switch via environment override, no toml mutation.
    if [ -f "$_tc_choice/starship.toml" ]; then
        STARSHIP_CONFIG="$_tc_choice/starship.toml"
        export STARSHIP_CONFIG
    fi

    THEMES_ACTIVE_PALETTE="${_tc_choice##*/}"
    export THEMES_ACTIVE_PALETTE
    return 0
}

# Select a random palette and apply it, falling back when none is usable.
themes_cycle() {
    local _tc_dir _tc_pal _tc_n _tc_rand _tc_i _tc_pick
    _tc_dir="${THEMES_DIR:-$HOME/.config/themes}"
    _tc_pal="$_tc_dir/palettes"

    # Collect palette directories via glob (builtin — no subprocess).
    # shellcheck disable=SC2086
    set -- "$_tc_pal"/*/

    if [ -d "$1" ]; then
        _tc_n=$#
        # $RANDOM is provided by bash and zsh; fall back to the PID elsewhere.
        _tc_rand="${RANDOM:-$$}"
        _tc_i=$(( (_tc_rand % _tc_n) + 1 ))
        eval "_tc_pick=\${$_tc_i}"
        _themes_apply "$_tc_pick" && return 0
    fi

    # Fallback: a dedicated fallback/ palette, if present.
    _themes_apply "$_tc_dir/fallback" && return 0

    # Last resort: expose the fixed fallback profile for prompts/scripts to read.
    THEMES_ACTIVE_PALETTE='fallback'
    THEMES_FALLBACK='true'
    THEMES_FALLBACK_BG='#0a0512'
    THEMES_FALLBACK_SURFACE='#100e23'
    THEMES_FALLBACK_ACCENT='#ff00aa'
    export THEMES_ACTIVE_PALETTE THEMES_FALLBACK \
        THEMES_FALLBACK_BG THEMES_FALLBACK_SURFACE THEMES_FALLBACK_ACCENT
    return 0
}

# Run on source (or on direct execution — the kitty swap still applies).
themes_cycle
