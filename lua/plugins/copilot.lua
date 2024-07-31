return {
  "zbirenbaum/copilot.lua",
  specs = {
    { import = "astrocommunity.completion.copilot-lua" },
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "zbirenbaum/copilot.lua" },
      opts = function(_, opts)
        local cmp, copilot = require "cmp", require "copilot.suggestion"
        local snip_status_ok, luasnip = pcall(require, "luasnip")
        if not snip_status_ok then return end
        local function has_words_before()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
        end
        if not opts.mapping then opts.mapping = {} end

        opts.mapping["<C-a>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.accept() end
        end)

        opts.mapping["<C-x>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.next() end
        end)

        opts.mapping["<C-z>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.prev() end
        end)

        opts.mapping["<C-left>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.accept_word() end
        end)

        opts.mapping["<C-down>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.accept_line() end
        end)

        opts.mapping["<C-j>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.accept_line() end
        end)

        opts.mapping["<C-y>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.dismiss() end
        end)

        return opts
      end,
    },
  },
}
