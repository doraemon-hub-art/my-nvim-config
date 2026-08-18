-- Mason: package manager for LSP servers, formatters, linters
return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"clangd",
				"lua-language-server",
				"pyright",
				"rust-analyzer",
				"vtsls",
				-- Formatters & linters
				"stylua",
				"shfmt",
				-- Tools
				"tree-sitter-cli",
			},
			auto_update = false,
			run_on_start = true,
		})
	end,
}
