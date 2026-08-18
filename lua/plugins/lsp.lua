-- LSP configuration: Neovim 0.11+ native API
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Load lspconfig to register server defaults into vim.lsp.config
		require("lspconfig")

		-----------------------------------------------------------
		-- 1. LspAttach: unified keymaps and features
		-----------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				local bufmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(
						mode,
						lhs,
						rhs,
						{ buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc }
					)
				end

				bufmap("n", "gD", vim.lsp.buf.declaration, "Declaration")
				bufmap("n", "gd", vim.lsp.buf.definition, "Definition")
				bufmap("n", "K", vim.lsp.buf.hover, "Hover docs")
				bufmap("n", "gi", vim.lsp.buf.implementation, "Implementation")
				bufmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
				bufmap("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
				bufmap("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
				bufmap("n", "<Leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "List workspace folders")
				bufmap("n", "<Leader>rn", vim.lsp.buf.rename, "Rename")
				bufmap({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, "Code action")
				bufmap("n", "gr", vim.lsp.buf.references, "References")
				bufmap("n", "<Leader>D", vim.lsp.buf.type_definition, "Type definition")
				bufmap("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
				bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
				-- <Leader>ld is global in keymaps.lua (diagnostic float)
				bufmap("n", "<Leader>lq", vim.diagnostic.setloclist, "Diagnostic to loclist")

				-- Enable inlay hints if supported
				if client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end

				-- Enable codelens if supported
				if client:supports_method("textDocument/codeLens") then
					vim.lsp.codelens.refresh({ bufnr = bufnr })
				end
			end,
		})

		-----------------------------------------------------------
		-- 2. Global capabilities (applied to all servers)
		-----------------------------------------------------------
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-----------------------------------------------------------
		-- 3. Per-server configuration overrides
		-----------------------------------------------------------
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
			},
		})

		vim.lsp.config("lua_ls", {
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
		})

		-- Others use lspconfig defaults — no override needed
		-- clangd: offsetEncoding etc. built into lspconfig default
		-- rust_analyzer, pyright, vtsls: defaults are fine

		-----------------------------------------------------------
		-- 4. Enable servers
		-----------------------------------------------------------
		local servers = { "clangd", "lua_ls", "rust_analyzer", "pyright", "vtsls" }
		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end

		-----------------------------------------------------------
		-- 5. User commands
		-----------------------------------------------------------
		-- Toggle inlay hints
		vim.api.nvim_create_user_command("LspToggleInlayHints", function()
			local enabled = vim.lsp.inlay_hint.is_enabled(0)
			if enabled then
				vim.lsp.inlay_hint.disable(0)
			else
				vim.lsp.inlay_hint.enable(0)
			end
			vim.notify("Inlay hints: " .. (enabled and "OFF" or "ON"))
		end, { desc = "Toggle LSP inlay hints" })
	end,
}
