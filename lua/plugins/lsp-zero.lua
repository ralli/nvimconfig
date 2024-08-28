return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = false,
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/nvim-cmp',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_cmp()

			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup({
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					['<C-y>'] = cmp.mapping.confirm({ select = false }),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-f>'] = cmp_action.luasnip_jump_forward(),
					['<C-b>'] = cmp_action.luasnip_jump_backward(),
					['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
					['<Down>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
				})
			})

			lsp_zero.on_attach(function(_, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
				lsp_zero.buffer_autoformat()
				vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
				vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
			end)

			require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {
					"efm",
					"bashls",
					"tsserver",
					"tailwindcss",
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
