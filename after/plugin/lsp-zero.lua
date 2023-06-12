local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		['lua_ls'] = { 'lua' },
		['rust_analyzer'] = { 'rust' },
		['gopls'] = { 'go' },
		['prettierd'] = { "css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"json",
			"scss",
			"less" },
	}
})

lsp.setup()
