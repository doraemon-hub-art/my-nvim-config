-- conform.nvim: code formatting
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			python = { "isort", "black" },
			go = { "gofumpt", "goimports" },
			rust = { "rustfmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			bash = { "shfmt" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
