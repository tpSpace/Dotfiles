return { 
  "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", 
  config = function()
    -- treesitter
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"lua", "javascript", "java", "rust", "c", "typescript", "cpp", "terraform", "yaml", "vim", "vimdoc", "sql", "lua", "go", "json"},
       hightlight = { enable = true },
      indent = { enable = true },
    })
  end
}
