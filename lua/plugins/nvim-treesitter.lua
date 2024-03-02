return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { "elixir", "eex" },
			highlight = {
				enable = { "exlixir", "eex" }
			},
		}
	end
}
