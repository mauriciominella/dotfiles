local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<PageDown>")
map({ "n", "v" }, "-", "<PageUp>")

map("n", "<leader>h", ":%s///<Left><Left>")

map("n", "<leader>/", ":nohlsearch<CR>", { silent = true })
map("n", "<leader>c", ":nohl<CR>", { silent = true })

vim.cmd([[cmap w!! w !sudo tee %]])

map("i", "<C-L>", "<Esc>")

map("n", "cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:"))
end)

map("v", "<leader>y", '"+y')
map("v", "<leader>d", '"+d')
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')
