-- conform.nvim: code formatting
local config_dir = vim.fn.stdpath("config") .. "/config/format"

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
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
		},
		formatters = {
			clang_format = {
				command = "clang-format",
				args = { "--style=file:" .. config_dir .. "/.clang-format" },
			},
			stylua = {
				command = "stylua",
				args = { "--config-path", config_dir .. "/stylua.toml", "-" },
			},
			prettier = {
				command = "prettier",
				args = { "--config", config_dir .. "/.prettierrc.json", "--stdin-filepath", "$FILENAME" },
			},
			shfmt = {
				command = "shfmt",
				args = { "--config-path", config_dir .. "/.shellformatrc", "-" },
			},
		},
		format_on_save = function()
			return nil
		end,
	},
}
