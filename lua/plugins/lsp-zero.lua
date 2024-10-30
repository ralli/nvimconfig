return {
	"VonHeikemen/lsp-zero.nvim",
	branch = 'v4.x',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/nvim-cmp',
	},
	config = function()
		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		-- This should be executed before you configure any language server
		local lspconfig_defaults = require('lspconfig').util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lspconfig_defaults.capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)

		require('mason').setup({})
		require('mason-lspconfig').setup({
			-- Replace the language servers listed here
			-- with the ones you want to install
			ensure_installed = { 'lua_ls', 'rust_analyzer', 'ts_ls' },
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
			},
		})

		local lsp_zero = require('lsp-zero')
		lsp_zero.extend_cmp()

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()

		cmp.setup({
			-- formatting = lsp_zero.cmp_format(),
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
			vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
			vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = bufnr })
		end)
	end
}
