-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto-create parent directories when saving a new file
augroup("create_dir", { clear = true })
autocmd("BufWritePre", {
	group = "create_dir",
	callback = function(args)
		local file = args.match
		if file:match("^%w+:[\\/][\\/]") then
			return
		end
		vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(file) or file, ":p:h"), "p")
	end,
	desc = "Auto-create parent directories",
})

-- Highlight on yank
augroup("highlight_yank", { clear = true })
autocmd("TextYankPost", {
	group = "highlight_yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
	desc = "Highlight yanked text",
})

-- Return to last edit position when opening files
augroup("last_edit_pos", { clear = true })
autocmd("BufReadPost", {
	group = "last_edit_pos",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Return to last edit position",
})

-- Make q close help, man, quickfix windows
augroup("q_close_windows", { clear = true })
autocmd("BufWinEnter", {
	group = "q_close_windows",
	callback = function(args)
		if not vim.g.q_close_windows then
			vim.g.q_close_windows = {}
		end
		if vim.g.q_close_windows[args.buf] then
			return
		end
		vim.g.q_close_windows[args.buf] = true
		for _, map in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
			if map.lhs == "q" then
				return
			end
		end
		if vim.tbl_contains({ "help", "nofile", "quickfix" }, vim.bo[args.buf].buftype) then
			vim.keymap.set("n", "q", "<Cmd>close<CR>", {
				desc = "Close window",
				buffer = args.buf,
				silent = true,
				nowait = true,
			})
		end
	end,
	desc = "q closes help/man/quickfix",
})
autocmd("BufDelete", {
	group = "q_close_windows",
	callback = function(args)
		if vim.g.q_close_windows then
			vim.g.q_close_windows[args.buf] = nil
		end
	end,
	desc = "Clean q_close_windows cache",
})

-- Check if files changed on editor focus / terminal close
augroup("checktime", { clear = true })
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = "checktime",
	callback = function()
		if vim.bo.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
	desc = "Check file changes on focus",
})

-- Refresh LSP codelens on InsertLeave and BufEnter
-- (nvim 0.12+: vim.lsp.codelens.refresh 已弃用，改用 enable(true, {bufnr=...}))
augroup("lsp_codelens_refresh", { clear = true })
autocmd({ "InsertLeave", "BufEnter" }, {
	group = "lsp_codelens_refresh",
	callback = function(args)
		if vim.lsp.codelens then
			pcall(vim.lsp.codelens.enable, true, { bufnr = args.buf })
		end
	end,
	desc = "Refresh LSP code lens",
})

-- Unlist quickfix buffers
augroup("unlist_quickfix", { clear = true })
autocmd("FileType", {
	group = "unlist_quickfix",
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
	desc = "Unlist quickfix buffers",
})

-- Terminal settings: disable line numbers, fold, sign column
augroup("terminal_settings", { clear = true })
autocmd("TermOpen", {
	group = "terminal_settings",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.signcolumn = "no"
	end,
	desc = "Disable numbers/signs in terminal",
})
