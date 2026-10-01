-- Treesitter: syntax highlighting, indentation
-- 注意：新版 nvim-treesitter（2024 重构后）的 setup() 只接受 install_dir，
-- 旧版选项 ensure_installed / auto_install / highlight / indent /
-- incremental_selection 均已移除（会被静默忽略）。
-- 高亮 / 缩进 / 折叠新版都不再自动开，必须自己挂（见下面 FileType 自动命令）。
-- parser 安装改用 install{} API。
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false, -- 官方明确不支持懒加载
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- 异步：启动不阻塞，缺哪个装哪个，已装过的直接跳过（新机器首次后台编译）
		require("nvim-treesitter").install({
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

		-- 高亮 + 缩进 + 折叠：没有 parser 的文件类型直接跳过（pcall 兜住）
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
			callback = function(args)
				if not pcall(vim.treesitter.start, args.buf) then
					return
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				-- foldlevel 99 = 打开文件时全部展开，折叠可用但不自动收（默认 0 会全收起来）
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldlevel = 99
			end,
			desc = "Treesitter: enable highlighting, indent and folding",
		})

		-- 增量选中：原始键位来自旧版 incremental_selection 选项
		local function select(target)
			return function()
				pcall(vim.treesitter.select, target)
			end
		end
		vim.keymap.set({ "n", "x" }, "<C-space>", select("parent"), { desc = "Treesitter: select node / expand" })
		vim.keymap.set({ "n", "x" }, "<bs>", select("child"), { desc = "Treesitter: shrink selection" })
	end,
}
