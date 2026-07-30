-- Colorscheme configuration
return {
	-- TokyoNight (active theme from original config, "tokyonight-day")
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "day",
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight-day")
		end,
	},
	-- Nightfox series (includes Carbonfox)
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
	},
	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
}
