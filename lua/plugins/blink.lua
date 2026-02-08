-- 2026 trending: blink.cmp - Performance-focused completion engine (nvim-cmp replacement)
return {
  "saghen/blink.cmp",
  opts = {
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },
    completion = {
      menu = { 
        border = "rounded", 
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSel",
      },
      documentation = {
        window = { 
          border = "rounded", 
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
        },
      },
      list = { 
        selection = { 
          preselect = false,
          auto_insert = true,
        },
      },
      ghost_text = { enabled = true },
    },
  },
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  version = "v0.*", 
}