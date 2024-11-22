local language = require('utils.language')

return language.register {
    tools = {
        'nil',
    },
    parsers = {
        'nix',
    },
    servers = {
        ['nil'] = {},
        nixd = {},
    },
    formatters = {
        nix = { 'alejandra' },
    },
    plugins = {
        after_core = {
            name = 'NixD setup',
            dir = '',
            config = function()
                require('lspconfig').nixd.setup {
                    settings = {
                        nixd = {
                            forrmatting = {
                                command = { 'alejandra' },
                            },
                        },
                    },
                    on_init = function(client, _)
                        client.server_capabilities.semanticTokensProvider = nil
                    end,
                }
                vim.api.nvim_set_hl(0, '@lsp.type.comment.nix', {})
            end,
        },
    },
}
