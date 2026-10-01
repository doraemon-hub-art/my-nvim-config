-- Neo-tree: file explorer

-- 这两个是自定义命令：neo-tree 新版已删掉 system_open / copy_selector
local function system_open(state)
	local node = state.tree:get_node()
	local path = node and (node.path or node:get_id())
	if path then
		vim.ui.open(path)
	end
end

local function copy_path(state)
	local node = state.tree:get_node()
	local path = node and (node.path or node:get_id())
	if path then
		-- 写无名寄存器：装了剪贴板工具时会跟着进系统剪贴板，没装至少寄存器里有
		vim.fn.setreg('"', path)
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Neotree",
	keys = {
		{ "<Leader>e", "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
		{
			"<Leader>o",
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end,
			desc = "Toggle Explorer Focus",
		},
	},
	opts = {
		close_if_last_window = true,
		sources = { "filesystem", "buffers", "git_status" },
		source_selector = {
			winbar = true,
			content_layout = "center",
		},
		default_component_configs = {
			indent = { padding = 0 },
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				default = "",
			},
			modified = { symbol = "●" },
			git_status = {
				symbols = {
					added = "✚",
					deleted = "✖",
					modified = "●",
					renamed = "➜",
					untracked = "★",
					ignored = "◌",
					unstaged = "✗",
					staged = "✓",
					conflict = "=",
				},
			},
		},
		window = {
			width = 30,
			mappings = {
				["<S-CR>"] = { system_open, desc = "System open" },
				["<Space>"] = false,
				["[b"] = "prev_source",
				["]b"] = "next_source",
				O = { system_open, desc = "System open" },
				Y = { copy_path, desc = "Copy path to clipboard" },
				h = "close_node",
				l = "open",
			},
		},
		filesystem = {
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
		},
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function()
					vim.opt_local.signcolumn = "auto"
					vim.opt_local.foldcolumn = "0"
				end,
			},
		},
	},
}
