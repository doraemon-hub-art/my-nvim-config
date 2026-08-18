-- Colorscheme configuration
return {
	-- TokyoNight (active theme)
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
	-- Nightfox series (lazy-loaded on :colorscheme switch)
	{
		"EdenEast/nightfox.nvim",
	},
	-- Kanagawa (lazy-loaded on :colorscheme switch)
	{
		"rebelot/kanagawa.nvim",
	},
}
