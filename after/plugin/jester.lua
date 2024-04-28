require("jester").setup({
  cmd = "jest -t '$result' -- $file", -- run command
  identifiers = {"test", "it"}, -- used to identify tests
  prepend = {"describe"}, -- prepend describe blocks
  expressions = {"call_expression"}, -- tree-sitter object used to scan for tests/describe blocks
  path_to_jest_run = 'jest', -- used to run tests
  path_to_jest_debug = './node_modules/.bin/jest', -- used for debugging
  terminal_cmd = ":vsplit | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
  dap = { -- debug adapter configuration
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'--inspect-brk', '$path_to_jest', '--no-coverage', '-t', '$result', '--', '$file'},
    args = { '--no-cache' },
    sourceMaps = false,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229,
    disableOptimisticBPs = true
  }
})



-- Usage
-- Run nearest test(s) under the cursor
-- :lua require"jester".run()
vim.keymap.set("n","<leader>rt", ":lua require\"jester\".run()<CR>")

--
-- Run current file
-- :lua require"jester".run_file()
vim.keymap.set("n","<leader>rf", "<cmd>lua require\"jester\".run_file()<CR>")
--
-- Run last test(s)
-- :lua require"jester".run_last()
vim.keymap.set("n","<leader>rl", "<cmd>lua require\"jester\".run_last()<CR>")
--
-- Debug nearest test(s) under the cursor
-- :lua require"jester".debug()
vim.keymap.set("n","<leader>dt", "<cmd>lua require\"jester\".debug()<CR>")
--
-- Debug current file
-- :lua require"jester".debug_file()
vim.keymap.set("n","<leader>df", "<cmd>lua require\"jester\".debug_file()<CR>")
--
-- Debug last test(s)
-- :lua require"jester".debug_last()
vim.keymap.set("n","<leader>dl", "<cmd>lua require\"jester\".debug_last()<CR>")


