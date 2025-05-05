local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.gopls.setup {
  cmd = { 'gopls' },
  -- for postfix snippets and analyzers
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
}
