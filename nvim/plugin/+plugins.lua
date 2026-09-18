vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
  -- main branch is required for Neovim 0.11+; the repo's default branch is the
  -- frozen legacy `master`, which is incompatible with Neovim 0.12's query API.
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/vim-test/vim-test" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rust-lang/rust.vim" },
  { src = "https://github.com/RRethy/base16-nvim" },
  { src = "https://github.com/obsidian-nvim/obsidian.nvim" }
})


require "mason".setup()
require "mini.pick".setup()
-- nvim-treesitter main branch: it only manages parsers + queries. Highlighting,
-- folds and injections are provided by Neovim itself (see the FileType autocmd).

-- Register the custom blade parser (main-branch API). This runs on the User
-- TSUpdate event, which install()/:TSUpdate fire after reloading the parser table.
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        branch = "main",
      },
    }
  end,
})
vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = "blade",
  },
})

-- Install parsers (async; no-op when already installed). main has no auto_install,
-- so the set is explicit. markdown/markdown_inline are omitted: Neovim bundles them.
require("nvim-treesitter").install({
  "blade", "css", "go", "gomod", "html", "lua", "php", "python", "swift", "sql",
})

-- Start treesitter highlighting for any buffer whose filetype has a parser.
-- pcall keeps filetypes without a parser from raising an error.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

require("obsidian").setup {
  legacy_commands = false,
  picker = {
    name = "mini.pick",
  },
  workspaces = {
    {
      name = "no-ai",
      path = "~/no-ai",
    },
  }
}
-- require "nvim-treesitter.configs".setup({
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
--   indent = {
--         enable = true,
--   },
-- })


require "matugen".setup()

require('lualine').setup({
    options = {
        theme = 'auto'
    }
})


-- vim test config
vim.cmd([[
  let test#php#pest#executable = 'php artisan test'
  let test#php#pest#options = '--colors=always'
  let test#php#pest#options = '-v'
  let test#strategy = 'terminal'
]])
