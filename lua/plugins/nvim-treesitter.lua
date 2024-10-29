return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { "elixir", "eex", "heex", "erlang" },

			highlight = {
				enable = { "elixir", "eex", "heex" },
				disable = { "lua", "c", "rust" }
			}
		}
	end
}
