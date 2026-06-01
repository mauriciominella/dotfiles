-- Only run prettier when the project actually ships a prettier/editorconfig
-- config. Otherwise prettier would reformat the whole file using its built-in
-- defaults, producing diffs on lines you never touched.
local prettier_config_files = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".prettierrc.json5",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.mjs",
  ".prettierrc.ts",
  ".prettierrc.toml",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
  "prettier.config.ts",
  ".editorconfig",
}

local function has_prettier_config(ctx)
  local from = ctx and ctx.dirname or vim.fn.getcwd()

  if vim.fs.find(prettier_config_files, { path = from, upward = true })[1] then
    return true
  end

  -- package.json with a "prettier" key counts too.
  local pkg = vim.fs.find("package.json", { path = from, upward = true })[1]
  if pkg then
    local ok, contents = pcall(vim.fn.readfile, pkg)
    if ok and string.find(table.concat(contents, "\n"), '"prettier"') then
      return true
    end
  end

  return false
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters = {
        -- Gate prettier on the presence of a project config so config-less
        -- repos are left untouched (no formatting with prettier defaults).
        prettier = {
          condition = function(_, ctx)
            return has_prettier_config(ctx)
          end,
        },
      },
      -- Prettier owns formatting (spacing/layout); ESLint handles lint fixes
      -- via the LSP on save (see autocmd below), matching VSCode/Cursor.
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "ruff_format" },
        sh = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
    },
    init = function()
      -- Mirror VSCode's `source.fixAll.eslint`: run ESLint's auto-fix on save
      -- for JS/TS buffers, before conform formats with prettier.
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.cjs" },
        callback = function(ev)
          local clients = vim.lsp.get_clients({ bufnr = ev.buf, name = "eslint" })
          if #clients > 0 then
            vim.cmd("silent! EslintFixAll")
          end
        end,
      })
    end,
  },
}
