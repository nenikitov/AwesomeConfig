--#region Helpers

-- Null-ls
local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
	vim.notify("Null-ls not available", vim.log.levels.ERROR)
	return
end

local formatting   = null_ls.builtins.formatting
local diagnostics  = null_ls.builtins.diagnostics
local completion   = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

local sources = {
    -- ESLint
    code_actions.eslint,
    diagnostics.eslint,
    formatting.eslint,
}

--#endregion

--#region

null_ls.setup({
	sources = sources
})

--#endregion

