# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that symlinks into `$HOME`.

## Usage

```bash
# Clone the repo
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Stow a package (e.g. i3)
stow i3

# Stow everything
stow */
```

## Packages

| Package | Description | Dependencies |
|---------|-------------|--------------|
| **i3** | Tiling WM with gruvbox theme, i3status, rofi, screen lock | i3-wm, i3status, i3lock, rofi, rofi-emoji, rofi-bluetooth, feh, maim, xclip, xdotool, xss-lock, xset, dex, nm-applet, playerctl, ghostty |
| **nvim** | Neovim with lazy.nvim, LSP, Treesitter, Telescope, Harpoon | neovim, git (LSP servers auto-installed via mason) |
| **tmux** | Terminal multiplexer | tmux |
| **terminal** | Ghostty terminal config | ghostty, JetBrainsMono Nerd Font |
| **gh-dash** | GitHub CLI dashboard with gruvbox theme | gh, gh-dash |
| **acpid** | Lid close/open display handler | acpid, xrandr |
| **wacom** | Wacom tablet setup | xf86-input-wacom, xrandr |
