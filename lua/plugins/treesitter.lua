return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "javascript", "java", "rust", "c", "typescript", "cpp", "terraform", "yaml", "vim", "vimdoc", "sql", "go", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
