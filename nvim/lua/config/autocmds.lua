local trail_group = vim.api.nvim_create_augroup("TrailingWhitespace", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = trail_group,
  callback = function()
    vim.api.nvim_set_hl(0, "Trail", { bg = "#dc322f" })
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = trail_group,
  callback = function()
    vim.fn.matchadd("Trail", [[\s\+$]], 100)
  end,
})

vim.api.nvim_create_user_command("StripWhitespace", function()
  local view = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.winrestview(view)
end, {})

vim.keymap.set("n", "<leader>y", "<cmd>StripWhitespace<CR>", { silent = true, desc = "Strip trailing whitespace" })

vim.api.nvim_create_user_command("Cheat", function()
  local path = vim.fn.expand("~/git/dotfiles/nvim/cheatsheet.txt")
  if vim.fn.filereadable(path) == 0 then
    vim.notify("cheatsheet not found at " .. path, vim.log.levels.ERROR)
    return
  end
  local lines = vim.fn.readfile(path)

  local width = 0
  for _, line in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(line)
    if len > width then
      width = len
    end
  end
  width = math.min(width + 4, math.floor(vim.o.columns * 0.9))
  local height = math.min(#lines, math.floor(vim.o.lines * 0.9))

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "cheatsheet"

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " Cheatsheet ",
    title_pos = "center",
  })

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
end, { desc = "Show keybinding cheatsheet" })
