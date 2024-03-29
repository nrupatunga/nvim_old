local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
	return
end

local servers = {
	"lua_ls",
	"cssls",
	"clangd",
	"html",
	"tsserver",
	--"pyright",
	"jedi_language_server",
	--"pylsp",
	"bashls",
	"jsonls",
	"yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "lua_ls" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end
	if server == "jedi_language_server" then
		local pyright_opts = require("user.lsp.settings.jedi")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end
	if server == "pylsp" then
		local pyright_opts = require("user.lsp.settings.pyls")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	lspconfig[server].setup(opts)
end
