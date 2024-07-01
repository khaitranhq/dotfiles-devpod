return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"tsserver",
					"gopls",
					"clangd",
					"bashls",
					"cssls",
					"jsonls",
					"dockerls",
					"docker_compose_language_service",
					"rust_analyzer",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		dependencies = "williamboman/mason.nvim",

		config = function()
			require("mason-tool-installer").setup({

				-- a list of all tools you want to ensure are installed upon
				-- start
				ensure_installed = {
					"stylua",
          "golines",
          "prettier",
          "shfmt",
          "black",
          "clang-format",
          "yamlfmt",
          "rustfmt"
				},
			})
		end,
	},
}
