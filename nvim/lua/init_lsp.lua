local lcfg = require('lspconfig')

local lsp_defaults = {
  flags = {
    debounce_text_changes = 100,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(_, _)
    vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  end
}

lcfg.util.default_config = vim.tbl_deep_extend(
  'force',
  lcfg.util.default_config,
  lsp_defaults
)

lcfg.zls.setup {}
lcfg.ccls.setup {}
lcfg.gopls.setup {}
lcfg.rust_analyzer.setup {}
lcfg.cmake.setup {}
lcfg.dockerls.setup {}
lcfg.html.setup {}
lcfg.rnix.setup {}
lcfg.vimls.setup {}
lcfg.sumneko_lua.setup {}
lcfg.ghcide.setup {}
lcfg.idris2_lsp.setup {}
lcfg.omnisharp.setup {}
