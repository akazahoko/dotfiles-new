return {
    "b0o/incline.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
        require("incline").setup({
            window = {
                margin = { horizontal = 0, vertical = 0 },
                padding = 0,
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                return {
                    { filename, gui = "bold" },
                }
            end,
        })
    end,
}
