-- lazy.nvim initialization
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.options")
require("config.keymaps")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	ui = { backdrop = 100 },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"zipPlugin",
			},
		},
	},
})
