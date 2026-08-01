-- Git plugins
return {
	-- gitsigns: git decorations in the sign column
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "契" },
				topdelete = { text = "契" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("n", "]g", gitsigns.next_hunk, "Next hunk")
				map("n", "[g", gitsigns.prev_hunk, "Previous hunk")

				map("n", "<Leader>gp", gitsigns.preview_hunk, "Preview hunk")
				map("n", "<Leader>gb", function()
					gitsigns.blame_line({ full = true })
				end, "Blame line")
				map("n", "<Leader>gd", gitsigns.diffthis, "Diff this")
				map("n", "<Leader>gD", function()
					gitsigns.diffthis("~")
				end, "Diff this ~")
				map("n", "<Leader>gt", gitsigns.toggle_deleted, "Toggle deleted")
				map("v", "<Leader>hs", function()
					gitsigns.stage_hunk()
				end, "Stage hunk")
				map("v", "<Leader>hr", function()
					gitsigns.reset_hunk()
				end, "Reset hunk")
			end,
		},
	},

	-- git-blame.nvim: show blame info inline
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = "  󰊢 <author> • <date> • <summary>",
			date_format = "%Y-%m-%d",
		},
	},

	-- diffview.nvim: powerful git diff viewer
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
	},
}
