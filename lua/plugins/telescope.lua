-- Telescope: fuzzy finder
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<Leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<Leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
		{ "<Leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Grep workspace" },
		{ "<Leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
		{ "<Leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
		{ "<Leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
		{ "<Leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
		{ "<Leader>f.", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
		{ "<Leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
		{ "<Leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
	},
	cmd = "Telescope",
	opts = {
		defaults = {
			preview = { treesitter = { enable = false } },
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			find_files = { hidden = true },
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		pcall(telescope.load_extension, "fzf")
	end,
}
