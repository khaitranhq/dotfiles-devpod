return {
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup(
                {
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
                        "rust_analyzer"
                    }
                }
            )
        end
    }
}
