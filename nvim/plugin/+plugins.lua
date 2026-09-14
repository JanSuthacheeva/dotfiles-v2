vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/vim-test/vim-test" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rust-lang/rust.vim" },
  { src = "https://github.com/RRethy/base16-nvim" }
})


require "mason".setup()
require "mini.pick".setup()
require "nvim-treesitter".setup({
  ensure_installed = {"blade", "css", "go", "gomod", "html", "lua", "php", "python", "swift", "sql"},
  auto_install = true,
    highlight = {
      enable = true,
  },

  config = function()
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = {"src/parser.c"},
          branch = "main",
        },
        filetype = "blade"
      }
      vim.filetype.add({
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      })
    end
})

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
