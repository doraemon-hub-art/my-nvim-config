-- Global keymaps -- AstroNvim defaults + user additions
local map = vim.keymap.set

local function o(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- =============================================================================
-- AstroNvim default normal mode mappings
-- =============================================================================

-- Better j/k: move by display lines with gj/gk when count is 0
map("n", "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true, desc = "Move cursor down" })
map("n", "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true, desc = "Move cursor up" })
map("x", "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true, desc = "Move cursor down" })
map("x", "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true, desc = "Move cursor up" })

-- Basic file operations
map("n", "<Leader>w", "<Cmd>w<CR>", o("Save"))
map("n", "<Leader>q", "<Cmd>confirm q<CR>", o("Quit Window"))
map("n", "<Leader>Q", "<Cmd>confirm qall<CR>", o("Exit"))
map("n", "<Leader>n", "<Cmd>enew<CR>", o("New File"))
map("n", "<C-s>", "<Cmd>silent! update! | redraw<CR>", o("Force write"))
map("n", "<C-q>", "<Cmd>q!<CR>", o("Force quit"))
map("n", "|", "<Cmd>vsplit<CR>", o("Vertical Split"))
map("n", "\\", "<Cmd>split<CR>", o("Horizontal Split"))
map("n", "<Leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
map("x", "<Leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Toggle comment insert below/above
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", o("Add Comment Below"))
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", o("Add Comment Above"))

-- Rename file
map("n", "<Leader>R", function()
	local old = vim.fn.expand("%")
	vim.ui.input({ prompt = "New name: ", default = old }, function(new)
		if new and new ~= "" then
			vim.fn.rename(old, new)
			vim.cmd("edit " .. new)
			vim.cmd("bdelete! " .. old)
		end
	end)
end, o("Rename file"))

-- Standard split navigation
map("n", "<C-h>", "<C-w>h", o("Move to left split"))
map("n", "<C-j>", "<C-w>j", o("Move to below split"))
map("n", "<C-k>", "<C-w>k", o("Move to above split"))
map("n", "<C-l>", "<C-w>l", o("Move to right split"))

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", o("Resize split up"))
map("n", "<C-Down>", ":resize +2<CR>", o("Resize split down"))
map("n", "<C-Left>", ":vertical resize -2<CR>", o("Resize split left"))
map("n", "<C-Right>", ":vertical resize +2<CR>", o("Resize split right"))

-- Navigate buffers
map("n", "]b", ":bnext<CR>", o("Next buffer"))
map("n", "[b", ":bprevious<CR>", o("Previous buffer"))

-- Buffer management
map("n", "<Leader>c", ":bdelete<CR>", o("Close buffer"))
map("n", "<Leader>C", ":bdelete!<CR>", o("Force close buffer"))
map("n", "<Leader>bd", function()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	if #bufs <= 1 then
		vim.cmd("bdelete!")
	else
		vim.cmd("bdelete")
	end
end, o("Close buffer"))
map("n", "<Leader>bc", function()
	local cur = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= cur and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype ~= "nofile" then
			vim.api.nvim_buf_delete(buf, { force = false })
		end
	end
end, o("Close all buffers except current"))
map("n", "<Leader>bC", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype ~= "nofile" then
			vim.api.nvim_buf_delete(buf, { force = false })
		end
	end
end, o("Close all buffers"))
map("n", "<Leader>bpr", ":bprev<CR>", o("Previous buffer"))

-- Navigate tabs
map("n", "]t", function()
	vim.cmd.tabnext()
end, o("Next tab"))
map("n", "[t", function()
	vim.cmd.tabprevious()
end, o("Previous tab"))

-- Diagnostics navigation
map("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, o("Previous error"))
map("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, o("Next error"))
map("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, o("Previous warning"))
map("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, o("Next warning"))
map("n", "gl", function()
	vim.diagnostic.open_float()
end, o("Hover diagnostics"))

-- Quickfix / location list
map("n", "]q", vim.cmd.cnext, o("Next quickfix"))
map("n", "[q", vim.cmd.cprev, o("Previous quickfix"))
map("n", "]Q", vim.cmd.clast, o("End quickfix"))
map("n", "[Q", vim.cmd.cfirst, o("Beginning quickfix"))
map("n", "]l", vim.cmd.lnext, o("Next loclist"))
map("n", "[l", vim.cmd.lprev, o("Previous loclist"))
map("n", "]L", vim.cmd.llast, o("End loclist"))
map("n", "[L", vim.cmd.lfirst, o("Beginning loclist"))
map("n", "<Leader>xq", ":copen<CR>", o("Quickfix List"))
map("n", "<Leader>xl", ":lopen<CR>", o("Location List"))

-- Package management
map("n", "<Leader>pi", function()
	require("lazy").install()
end, o("Plugins Install"))
map("n", "<Leader>ps", function()
	require("lazy").home()
end, o("Plugins Status"))
map("n", "<Leader>pS", function()
	require("lazy").sync()
end, o("Plugins Sync"))
map("n", "<Leader>pu", function()
	require("lazy").check()
end, o("Plugins Check Updates"))
map("n", "<Leader>pU", function()
	require("lazy").update()
end, o("Plugins Update"))

-- Language tools
map("n", "<Leader>ld", function()
	vim.diagnostic.open_float()
end, o("Hover diagnostics"))

-- =============================================================================
-- Insert mode
-- =============================================================================
map("i", "<A-h>", "<Left>", o("Move left"))
map("i", "<A-j>", "<Down>", o("Move down"))
map("i", "<A-k>", "<Up>", o("Move up"))
map("i", "<A-l>", "<Right>", o("Move right"))

-- =============================================================================
-- Visual mode
-- =============================================================================
map("v", "<", "<gv", o("Unindent line"))
map("v", ">", ">gv", o("Indent line"))
map("v", "<A-j>", ":m '>+1<CR>gv=gv", o("Move line down"))
map("v", "<A-k>", ":m '<-2<CR>gv=gv", o("Move line up"))

-- =============================================================================
-- Terminal mode
-- =============================================================================
map("t", "<Esc>", "<C-\\><C-n>", o("Exit terminal mode"))
map("t", "<C-h>", function()
	if vim.api.nvim_win_get_config(0).zindex then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-h>", true, false, true), "n", false)
	else
		vim.cmd.wincmd("h")
	end
end, o("Terminal left window"))
map("t", "<C-j>", function()
	if vim.api.nvim_win_get_config(0).zindex then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, false, true), "n", false)
	else
		vim.cmd.wincmd("j")
	end
end, o("Terminal down window"))
map("t", "<C-k>", function()
	if vim.api.nvim_win_get_config(0).zindex then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-k>", true, false, true), "n", false)
	else
		vim.cmd.wincmd("k")
	end
end, o("Terminal up window"))
map("t", "<C-l>", function()
	if vim.api.nvim_win_get_config(0).zindex then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, false, true), "n", false)
	else
		vim.cmd.wincmd("l")
	end
end, o("Terminal right window"))

-- =============================================================================
-- Additional user mappings (porting from old config)
-- =============================================================================

-- Clear search highlight with Escape
map("n", "<Esc>", function()
	if vim.v.hlsearch and vim.v.hlsearch > 0 then
		return ":nohlsearch<CR><Esc>"
	end
	return "<Esc>"
end, { expr = true, desc = "Escape / Clear search highlight" })

-- Keep cursor in place when joining lines
map("n", "J", "mzJ`z", o("Join lines"))

-- File header comment (<Leader>df)
map("n", "<Leader>df", function()
	local file = vim.fn.expand("%:t")
	local date = os.date("%Y-%m-%d")
	local year = os.date("%Y")
	local lines = {
		"/**",
		" * @file " .. file,
		" * @author doraemon-hub-art",
		" * @brief ",
		" * @date " .. date,
		" *",
		" * @copyright Copyright (c) " .. year,
		" */",
	}
	vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
	vim.api.nvim_win_set_cursor(0, { 4, 11 })
end, o("Generate file header"))
