return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                python = { "string", "comment" },
            },
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
        })
    end,
}
