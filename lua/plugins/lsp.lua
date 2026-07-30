-- LSP configuration: mason + lspconfig + mason-lspconfig
return {
	-- Mason: install LSP servers, formatters, linters
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {},
	},

	-- mason-lspconfig: bridge between mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"vtsls", -- TypeScript/JavaScript
				"rust_analyzer", -- Rust
				"pyright", -- Python
			},
			automatic_installation = true,
		},
	},

	-- lspconfig: configure language servers (nvim 0.11+ vim.lsp.config API)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Load lspconfig default configs into vim.lsp.config registry
			-- (required for mason-lspconfig auto-install to work)
			require("lspconfig")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP keymaps attached on LspAttach
			local on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set("n", "<Leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
				vim.keymap.set("n", "<Leader>ld", vim.diagnostic.open_float, bufopts)
				vim.keymap.set("n", "<Leader>lq", vim.diagnostic.setloclist, bufopts)
			end

			-- Server-specific configurations
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
				clangd = {
					capabilities = { offsetEncoding = "utf-8" },
				},
				rust_analyzer = {},
				vtsls = {},
				pyright = {},
			}

			-- Setup each server using vim.lsp.config (nvim 0.11+ API)
			for name, opts in pairs(servers) do
				opts.capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})
				opts.on_attach = on_attach
				-- Merge user options over the default mason-lspconfig config
				local existing = vim.lsp.config[name] or {}
				vim.lsp.config[name] = vim.tbl_deep_extend("force", existing, opts)
				vim.lsp.enable(name)
			end

			-- Inlay hints toggle (Neovim 0.10+ API)
			vim.api.nvim_create_user_command("LspToggleInlayHints", function()
				local enabled = vim.lsp.inlay_hint.is_enabled(0)
				if enabled then
					vim.lsp.inlay_hint.disable(0)
				else
					vim.lsp.inlay_hint.enable(0)
				end
				vim.notify("Inlay hints: " .. (enabled and "OFF" or "ON"))
			end, { desc = "Toggle LSP inlay hints" })

			-- Semantic tokens toggle
			local semantic_tokens_enabled = true
			vim.api.nvim_create_user_command("LspToggleSemanticTokens", function()
				semantic_tokens_enabled = not semantic_tokens_enabled
				if semantic_tokens_enabled then
					vim.schedule(function()
						vim.cmd("edit")
					end)
				end
				vim.notify("Semantic tokens: " .. (semantic_tokens_enabled and "ON" or "OFF"))
			end, { desc = "Toggle LSP semantic tokens" })
		end,
	},

	-- nvim-lsp-signature: show function signature popup
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			hint_enable = true,
			hint_prefix = "󰁡 ",
			handler_opts = { border = "rounded" },
		},
	},
}
