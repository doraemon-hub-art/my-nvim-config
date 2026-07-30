-- Treesitter: syntax highlighting, indentation, folding
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"doxygen",
			"c",
			"cpp",
			"cmake",
			"rust",
			"python",
			"bash",
			"javascript",
			"typescript",
			"proto",
			"markdown",
			"markdown_inline",
		},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
}
