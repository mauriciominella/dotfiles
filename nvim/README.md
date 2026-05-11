# nvim

Modern Lua-based Neovim configuration.

## Layout

```
init.lua                  # entrypoint
lua/
  config/
    options.lua           # vim options (leader, indent, undo, etc.)
    keymaps.lua           # non-plugin keybindings
    autocmds.lua          # trailing whitespace, etc.
    lazy.lua              # lazy.nvim bootstrap
  plugins/
    colorscheme.lua       # solarized8
    ui.lua                # lualine, neo-tree, web-devicons, winresizer
    telescope.lua         # fuzzy finder
    lsp.lua               # mason + lspconfig + nvim-cmp + LuaSnip
    treesitter.lua        # syntax/indent
    git.lua               # gitsigns + fugitive
    editing.lua           # surround, comment, autopairs, flash, visual-multi
    formatting.lua        # conform.nvim (prettier/eslint/stylua/ruff/shfmt)
    misc.lua              # tmux-navigator, jsdoc, vim-notes
```

## Install

```sh
./install.sh
```

Then launch `nvim`. lazy.nvim will install plugins on first run; mason will install LSP servers (`ts_ls`, `eslint`, `lua_ls`, `jsonls`, `yamlls`, `bashls`, `pyright`).

## Health checks

- `:Lazy` — plugin manager
- `:Mason` — LSP/formatter/linter installer
- `:checkhealth` — overall diagnostics

## Leader: `,`

### Files / buffers
| Key | Action |
|-----|--------|
| `;` | Telescope buffers |
| `,o` / `,ff` | Telescope find_files |
| `,g` / `,fg` | Telescope live_grep |
| `,j` | Grep word under cursor |
| `,fb` / `,b` | Buffers |
| `,fh` | Help tags |
| `,cb` | Current buffer fuzzy |
| `,ct` | Current buffer tags |
| `,s` | LSP document symbols |

### File tree
| Key | Action |
|-----|--------|
| `,t` | Toggle neo-tree |
| `,f` | Reveal current file in tree |

### LSP
| Key | Action |
|-----|--------|
| `gd` / `,dd` | Definition |
| `gy` | Type definition |
| `gi` / `,dj` | Implementation |
| `gr` / `,dr` | References |
| `K` | Hover docs |
| `,rn` | Rename symbol |
| `,ca` | Code action |

### Git
| Key | Action |
|-----|--------|
| `gb` | Git blame line (gitsigns) |

### Editing
| Key | Action |
|-----|--------|
| `gcc` / `gc` | Comment line / selection |
| `,w` | Flash jump |
| `,z` | JsDoc |
| `,y` | Strip trailing whitespace (`:StripWhitespace`) |
| `<C-k>` | Snippet expand/jump |

### Search / misc
| Key | Action |
|-----|--------|
| `,h` | Find & replace prompt |
| `,/` or `,c` | Clear highlight |
| `<Space>` / `-` | PageDown / PageUp |
| `cp` | Copy current file path to clipboard |
| `,p` / `,P` | Paste from system clipboard |
| `,y` / `,d` (visual) | Yank / delete to system clipboard |
| `w!!` | Sudo write |
| `<C-L>` (insert) | Esc |
