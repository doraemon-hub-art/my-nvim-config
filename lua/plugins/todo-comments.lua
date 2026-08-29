return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost",
  opts = {
    colors = {
      info = { "#2563eb" },
      hint = { "#0d9488" },
    },
    keywords = {
      TODO = { icon = "", color = "info" },
      NOTE = { icon = "", color = "hint", alt = { "INFO" } },
    },
  },
}
