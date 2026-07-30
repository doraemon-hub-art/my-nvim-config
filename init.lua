-- Bootstrap lazy.nvim and load config
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local result = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" },
			{ "Press any key to exit...", "MoreMsg" },
		}, true, {})
		vim.fn.getchar()
		vim.cmd.quit()
	end
end
vim.opt.rtp:prepend(lazypath)

require("config.lazy")
require("config.autocmds")
