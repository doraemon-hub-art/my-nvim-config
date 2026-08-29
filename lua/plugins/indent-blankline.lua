return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  config = function()
    local ibl = require("ibl")
    ibl.setup({
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      },
    })
  end,
}
