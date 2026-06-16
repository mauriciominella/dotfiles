; WORKAROUND: nvim-treesitter `master` branch does not support Neovim 0.12.
; Its markdown injections.scm uses the custom `#set-lang-from-info-string!`
; directive, which assumes the pre-0.11 match-table API (single node per
; capture). On Neovim 0.11+ a capture is a list of nodes, so the directive
; feeds a nil/malformed node into vim.treesitter.get_range() -> node:range(),
; crashing the highlighter when opening any markdown file.
;
; This file shadows nvim-treesitter's query (our config dir wins the rtp race),
; mirroring Neovim 0.12's built-in runtime query, which uses the standard
; @injection.language capture and works on 0.12.
;
; DELETE this file once nvim-treesitter is migrated to the `main` branch.
; See: nvim/lua/plugins/treesitter.lua

(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
