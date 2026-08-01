-- Treesitter: syntax highlighting, indentation
-- 注意：新版 nvim-treesitter（2024 重构后）的 setup() 只接受 install_dir，
-- 旧版选项 ensure_installed / auto_install / highlight / indent /
-- incremental_selection 均已移除（会被静默忽略）。
-- 高亮与 indent 新版默认启用；parser 安装改用 install{} API。
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false, -- 官方明确不支持懒加载
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- 安装缺失的 parser（已安装的自动跳过，异步执行）
		-- 无需安装的内置 parser：lua, vim, vimdoc, query, markdown,
		-- markdown_inline, c（nvim 自带）
		local ok, ts = pcall(require, "nvim-treesitter")
		if ok then
			ts.install({
				"doxygen",
				"cpp",
				"cmake",
				"rust",
				"python",
				"bash",
				"javascript",
				"typescript",
				"proto",
			})
		end
	end,
}
