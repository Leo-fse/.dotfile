local on_attach = function(client, bufnr)
	-- LSPのフォーマットを無効
	client.server_capabilities.documentFormattingProvider = format

	-- local set = vim.keymap.set
	--set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	-- set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	-- set("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	--set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	-- set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	-- set("n", "ma", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	-- set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	-- set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
	-- set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	-- set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
})

-- Diagnostic symbols in the sign column
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Diagnostic Settings
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	severity_sort = true,
})

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = false,
	float = {
		source = "always", -- Or "if_many"
	},
})
