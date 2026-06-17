# dotfiles
My dotfiles

## tmux

Config lives in [`tmux/tmux.conf`](tmux/tmux.conf). **Prefix is `Ctrl-a`** (remapped from `Ctrl-b`).
Tip: press `prefix + ?` to open a fuzzy **command palette** of every binding below — and run it.

### Key bindings

| Key | Action |
|-----|--------|
| `prefix` `?` | Command palette — fuzzy-search every binding and run it (fzf popup) |
| `prefix` `g` | Watch the latest **GitHub Actions** run in a split (`gh run watch`) |
| `prefix` `O` | Session picker (tmux-sessionx, fzf) |
| `prefix` `u` | Split pane below, in the current dir |
| `prefix` `o` | Split pane right, in the current dir |
| `prefix` `c` | New window, in the current dir |
| `prefix` `t` | Split right and open vim |
| `prefix` `h` `j` `k` `l` | Move to pane left / down / up / right |
| `prefix` `C-h` / `C-l` | Previous / next window |
| `Shift` + arrows | Resize the active pane (no prefix needed) |
| `prefix` `C-a` | Jump to the last-used pane |
| `prefix` `b` | Toggle **silence** alert for this window (notify after 30s quiet) |
| `prefix` `m` | Toggle **activity** alert for this window |
| `prefix` `r` | Reload the config |
| `prefix` `K` | Kill the current session |
| `prefix` `I` / `U` | Install / update plugins (TPM) |

Smart `Ctrl-h/j/k/l` pane-and-vim navigation is also active (via vim-tmux-navigator), no prefix needed.

**Copy mode** (vi keys): `v` start selection, `y` copy to the macOS clipboard (`pbcopy`) while keeping your scroll position.

### Status bar & visuals (Solarized)

- **Active tab** highlighted with a solid blue pill; inactive tabs stay dim.
- **Tab labels** auto-show the active pane's command + dir, but a manual rename (`prefix` `,`) takes over and sticks until you re-enable auto naming (`setw automatic-rename on`).
- **Git branch badge** for the active pane on the right of the status bar.
- **Per-split git branch** shown on each pane's top border (each split shows its own).
- **`SYNC` flag** (loud red) whenever `synchronize-panes` is on, so you don't fan-fire a command into every split.
- **Claude Code panes** display `✳ claude` instead of the meaningless version-string process name.
- **Per-split task labels** on pane borders (Claude's current task, or the running command).
- **Loud bell / activity styling** on windows that need attention.

### Behavior

- Mouse support on, vi mode keys, 1-based window/pane indexing, windows renumber on close, 10k-line scrollback, true-color, instant `Esc`.

### Plugins (via [TPM](https://github.com/tmux-plugins/tpm))

- `tmux-sensible` — sane defaults
- `tmux-open` — open highlighted paths/URLs
- `tmux-resurrect` + `tmux-continuum` — auto-save/restore sessions (incl. vim/nvim), restored on boot
- `tmux-yank` — clipboard integration
- `vim-tmux-navigator` — seamless vim/tmux split navigation
- `tmux-sessionx` — fzf session manager (`prefix + O`)

### Requirements

`fzf` (command palette + session picker), the `gh` CLI (Actions watcher), TPM (plugins), and a true-color terminal.

# Manual settings
Ability to keep a key pressed on VSCode on Mac
```
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## symlinks
./.tmux.conf -> /Users/mauricio/git/dotfiles/tmux/tmux.conf
./.editorconfig -> /Users/mauricio/git/dotfiles/vim/editorconfig
./.vimrc -> /Users/mauricio/git/dotfiles/vim/vimrc


ln -s /Users/mauricio/git/dotfiles/vim/plugins.vim /Users/mauricio/.vim/plugins.vim 
ln -s /Users/mauricio/git/dotfiles/vim/bundles.vim /Users/mauricio/.vim/bundles.vim 
ln -s /Users/mauricio/git/dotfiles/vim/macros.vim /Users/mauricio/.vim/macros.vim
ln -s /Users/mauricio/git/dotfiles/vim/global.vim /Users/mauricio/.vim/global.vim 
ln -s /Users/mauricio/git/dotfiles/vim/before.vim /Users/mauricio/.vim/before.vim 
ln -s /Users/mauricio/git/dotfiles/tmux/tmux.conf /Users/mauricio/.tmux.conf 
ln -s /Users/mauricio/git/dotfiles/zsh/zshrc /Users/mauricio/.zshrc 
ln -s /Users/mauricio/git/dotfiles/vscode/settings.json /Users/mauricio/Library/Application Support/Code/User/settings.json 
ln -s /Users/mauricio/git/dotfiles/vscode/keybindings.json /Users/mauricio/Library/Application Support/Code/User/keybindings.json 
