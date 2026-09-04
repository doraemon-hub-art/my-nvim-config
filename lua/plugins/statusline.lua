return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local icon = require("hieulw.icons")
		local lualine = require("lualine")

		-- ── system info — timer-driven, zero IO in provider ─────────

		local sys_cache = ""
		local cpu_prev

		local function update_stats()
			local parts = {}

			-- memory
			local f = io.open("/proc/meminfo")
			if f then
				local total, avail
				for line in f:lines() do
					if line:find("^MemTotal:") then
						total = tonumber(line:match("%d+"))
					elseif line:find("^MemAvailable:") then
						avail = tonumber(line:match("%d+"))
					end
				end
				f:close()
				if total and avail then
					table.insert(parts, string.format(" %.1fG/%.1fG", (total - avail) / 1e6, total / 1e6))
				end
			end

			-- cpu
			local f = io.open("/proc/stat")
			if f then
				local line = f:read()
				f:close()
				if line then
					local _, _, user, nice, sys, idle, iowait, irq, softirq, steal =
						line:find("^cpu%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
					if user then
						local total = user + nice + sys + idle + iowait + irq + softirq + (steal or 0)
						local idle_total = idle + iowait
						if cpu_prev then
							local dtotal = total - cpu_prev.total
							local didle = idle_total - cpu_prev.idle
							if dtotal > 0 then
								table.insert(parts, string.format(" %.0f%%%%", (dtotal - didle) / dtotal * 100))
							end
						end
						cpu_prev = { total = total, idle = idle_total }
					end
				end
			end

			-- thermal
			local f = io.open("/sys/class/thermal/thermal_zone0/temp")
			if f then
				local v = f:read("*n")
				f:close()
				if v then
					table.insert(parts, string.format(" %d°C", v / 1000))
				end
			end

			if #parts > 0 then
				sys_cache = table.concat(parts, "  ")
			end
		end

		local luv = vim.uv or vim.loop
		local timer = luv.new_timer()
		timer:start(0, 2000, vim.schedule_wrap(update_stats))

		local sys_info = function()
			return sys_cache
		end

		-- ── diff component with gitsigns source ─────────────────────

		local diff = {
			"diff",
			source = function()
				local gs = vim.b.gitsigns_status_dict
				if gs then
					return { added = gs.added, modified = gs.changed, removed = gs.removed }
				end
			end,
			symbols = {
				added = icon.git.LineAdded .. " ",
				modified = icon.git.LineModified .. " ",
				removed = icon.git.LineRemoved .. " ",
			},
			colored = true,
			always_visible = false,
		}

		-- ── diagnostics component ──────────────────────────────────

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = {
				error = icon.diagnostics.Error,
				warn = icon.diagnostics.Warning,
				info = icon.diagnostics.Info,
				hint = icon.diagnostics.Hint,
			},
			colored = true,
			update_in_insert = false,
			always_visible = false,
		}

		-- ── lsp status component ───────────────────────────────────

		local lsp_status = {
			"lsp_status",
			icon = icon.ui.LSP,
			symbols = {
				spinner = icon.spinner,
				done = "",
				separator = " ",
			},
			ignore_lsp = {},
			show_name = true,
		}

		-- ── scroll progress component ──────────────────────────────

		local scroll_progress = function()
			local ok, result = pcall(function()
				local bufnr = vim.api.nvim_win_get_buf(0)
				local total = vim.api.nvim_buf_line_count(bufnr)
				if total == 0 then
					return ""
				end
				local cur = vim.api.nvim_win_get_cursor(0)[1]
				local pct = math.floor(cur / total * 100 + 0.5)
				local bar_width = 10
				local filled = math.floor(pct / 100 * bar_width + 0.5)
				local bar = string.rep("█", filled) .. string.rep("░", bar_width - filled)
				return string.format("%d%%%% %s", pct, bar)
			end)
			if ok then
				return result
			end
			return ""
		end

		-- ── lualine setup ──────────────────────────────────────────

		lualine.setup({
			options = {
				theme = "auto",
				globalstatus = true,
				section_separators = "",
				component_separators = "",
				disabled_filetypes = { "mason", "lazy", "NvimTree" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", sys_info },
				lualine_c = {},
				lualine_x = { diff, diagnostics, { "filetype", icon_only = true }, lsp_status, scroll_progress },
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_c = { "filename" },
			},
		})
	end,
}
