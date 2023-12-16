return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/nvim-cmp',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			local lsp_zero = require('lsp-zero').preset({})

			lsp_zero.on_attach(function(_, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())

			lsp_zero.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					['lua_ls'] = { 'lua' },
					['rust_analyzer'] = { 'rust' },
					['gopls'] = { 'go' },
					--					['clang-format'] = { 'c', 'cpp' },
					['efm'] = {
						"css",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"json",
						"scss",
						"less" },
				}
			})

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {
					"efm",
					"bashls",
					"tsserver",
					"tailwindcss",
					"pyright",
					"html",
					"cssls",
					"lua_ls",
					"emmet_ls",
					"jsonls",
					"rust_analyzer",
					"gopls",
				},

				automatic_installation = true,
				handlers = {
					lsp_zero.default_setup,
				},
			})
		end
	},
}
