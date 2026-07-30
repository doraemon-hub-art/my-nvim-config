-- Additional plugins from original AstroNvim config
return {
	-- Neogen: Doxygen annotation generator
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			enabled = true,
			languages = {
				cpp = {
					template = { annotation_convention = "doxygen" },
				},
			},
		},
		keys = {
			{
				"<Leader>dg",
				function()
					require("neogen").generate()
				end,
				desc = "Generate annotation",
			},
		},
	},

	-- ToggleTerm: floating terminal
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal" },
			{ "<C-\\>", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal", mode = "t" },
		},
		opts = {
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			float_opts = {
				border = "curved",
				winblend = 3,
			},
		},
	},

	-- Smear cursor: smooth cursor animation
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			smear_between_buffers = true,
			smear_between_neighbor_lines = true,
			scroll_buffer_space = true,
			legacy_computing_symbols_support = false,
			smear_insert_mode = true,
		},
	},

	-- Alpha: startup dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				"_______ _    _ ______   ____  ______  _____ _______",
				"|__   __| |  | |  ____| |  _ \\|  ____|/ ____|__   __|",
				"   | |  | |__| | |__    | |_) | |__  | (___    | |",
				"   | |  |  __  |  __|   |  _ <|  __|  \\___ \\   | |",
				"   | |  | |  | | |____  | |_) | |____ ____) |  | |",
				"   |_|  |_|  |_|______| |____/|______|_____/   |_|",
				"",
				"",
				" _   ___      _______ __  __",
				"| \\ | \\ \\    / /_   _|  \\/  |",
				"|  \\| |\\ \\  / /  | | | \\  / |",
				"| . ` | \\ \\/ /   | | | |\\/| |",
				"| |\\  |  \\  /   _| |_| |  | |",
				"|_| \\_|   \\/   |_____|_|  |_|",
			}
			dashboard.section.buttons.val = {
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  Find files", ":Telescope find_files <CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "󰊄  Live grep", ":Telescope live_grep <CR>"),
				dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
			}
			dashboard.section.footer.val = "astronvim → nvim-next ✨"
			return dashboard.config
		end,
	},

	-- Noice: improved UI for cmdline, messages, etc.
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = { enabled = true },
				signature = { enabled = true },
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	},

	-- Render Markdown: better markdown rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "Avante" },
		opts = {},
	},

	-- Rainbow delimiters: color-matched brackets
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = function()
			local rd = require("rainbow-delimiters")
			require("rainbow-delimiters.setup").setup({
				strategy = {
					[""] = rd.strategy["global"],
					vim = rd.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			})
		end,
	},

	-- Colorful window separator
	{
		"nvim-zh/colorful-winsep.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Neoscroll: smooth scrolling
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		opts = {
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			easing_function = "cubic",
			pre_hook = nil,
			post_hook = nil,
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		},
	},

	-- nvim-autopairs: auto-close brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- Colorizer: highlight color codes
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = { user_default_options = { names = false } },
		config = function(_, opts)
			require("colorizer").setup(opts)
		end,
	},

	-- which-key: show available keymaps
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "[", "]" },
		opts = {
			preset = "modern",
			defaults = {},
			icons = {
				group = "",
				rules = false,
				separator = "-",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<leader>", group = "LEADER", icon = "󰘶" },
				-- Section groups matching AstroNvim defaults
				{ "<leader>f", group = "Find" },
				{ "<leader>p", group = "Packages" },
				{ "<leader>l", group = "Language Tools" },
				{ "<leader>u", group = "UI/UX" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>d", group = "Debugger" },
				{ "<leader>g", group = "Git" },
				{ "<leader>S", group = "Session" },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>x", group = "Quickfix/Lists" },
				{ "[", group = "Prev" },
				{ "]", group = "Next" },
			})
		end,
	},

	-- mason-tool-installer: auto-install Mason packages
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"tree-sitter-cli",
			},
		},
	},
}
