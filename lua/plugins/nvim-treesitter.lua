return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { "elixir", "eex", "heex", "erlang", "prisma" },

			highlight = {
				enable = { "elixir", "eex", "heex", "prisma" },
				disable = { "lua", "c", "rust" }
			}
		}
	end
}
