local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
	"jdtls",
	"rust_analyzer",
	"clangd",
	"cmake",
	-- "r_language_server",
	"pyright",
	"html",
	"cssls",
	"tsserver",
	"bashls",
	"jsonls",
	"yamlls",
	"dockerls",
  "lua_ls"
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

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

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "rust_analyzer" then
		local rust_opts = require("user.lsp.settings.rust")
		require("rust-tools").setup(rust_opts)
		goto continue
	end

	if server == "jdtls" then --jdtls is handled by ftplugin call
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
